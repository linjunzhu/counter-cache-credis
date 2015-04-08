require "counter/cache/redis/version"

module Counter
  module Cache
    module Redis

      # 类方法
      module classMethods

        # 设置最小以及最大延迟
        def counter_cache_redis(options = {})
          attr_accessor :counter_delay
          self.counter_delay = options[:delay] || 20
          include Counter::Cache::Redis::instanceMethods
        end

      end

      # 实例方法
      module instanceMethods

        # 读出此时的值
        def counter_value

        end

        # 修改值
        def update_counter

        end

      end

    end
  end
end


ActionView::Base.send :include, Counter::Cache::Redis