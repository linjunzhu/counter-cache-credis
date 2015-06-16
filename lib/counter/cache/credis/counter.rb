module Counter
  module Cache
    module Credis

      def self.included(receiver)
        receiver.extend ClassMethods
      end

      module ClassMethods

        def defind_column_getter(column)
          self.class_eval do
            define_method("get_#{column}_cache") do
              self.send(column) + RedisCli.new.get("#{self.class.table_name}/#{column}#{self.id}").to_i
            end
          end
        end

        def counter_cache_redis(options = {})
          mattr_accessor :column_delay
          delay = options[:delay] || 20
          column = options[:column] || 'views_count'
          self.column_delay = {} if self.column_delay.nil?
          self.column_delay[column] = delay
          defind_column_getter(column)
          include Counter::Cache::Credis::InstanceMethods
        end

      end

      module InstanceMethods

        # 增加
        def increase_counter(column = 'views_count')
          redis = RedisCli.new
          counter_redis = redis.get("#{self.class.table_name}/#{column}#{self.id}").to_i
          counter_redis = 0 if !counter_redis
          counter_redis += 1
          if counter_redis >= column_delay[column]
            # 计算出总读数
            views_count_temp = counter_redis + (self.send(column) || 0)
            counter_redis = 0
            self.send("#{column}=", views_count_temp)
            self.save
          end

          redis.set("#{self.class.table_name}/#{column}#{self.id}", counter_redis)
        end

         # 减低
        def reduce_counter(column = 'views_count')
          redis = RedisCli.new
          counter_redis = redis.get("#{self.class.table_name}/#{column}#{self.id}").to_i
          counter_redis = 0 if !counter_redis
          counter_redis -= 1
          redis.set("#{self.class.table_name}/#{column}#{self.id}", counter_redis)
        end

      end
    end
  end
end


ActiveRecord::Base.send :include, Counter::Cache::Credis