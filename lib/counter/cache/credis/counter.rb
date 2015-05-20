module Counter
  module Cache
    module Credis

      def self.included(receiver)
        receiver.extend ClassMethods
      end

      module ClassMethods

        def defind_column_getter
          self.class_eval do
            define_method("get_#{self.column}_cache") do
              self.send(self.column) + Redis.new.get("#{self.class.table_name}/#{self.id}").to_i
            end
          end
        end

        def counter_cache_redis(options = {})
          mattr_accessor :counter_delay, :column
          self.counter_delay = options[:delay] || 1
          self.column = options[:column] || 'views_count'
          defind_column_getter if options[:column]
          include Counter::Cache::Credis::InstanceMethods
        end

      end

      module InstanceMethods

        # 修改值
        def update_counter
          redis = RedisCli.new
          # 先读出redis中的值
          views_count_redis = redis.get("#{self.class.table_name}/#{self.id}").to_i
          views_count_redis = 0 if !views_count_redis
          views_count_redis += 1

          if views_count_redis >= self.counter_delay
            # 计算出总读数
            views_count_temp = views_count_redis + (self.send(self.column) || 0)
            views_count_redis = 0
            self.send("#{self.column}=", views_count_temp)
            self.save
          end

          redis.set("#{self.class.table_name}/#{self.id}", views_count_redis)

        end
      end
    end
  end
end


ActiveRecord::Base.send :include, Counter::Cache::Credis