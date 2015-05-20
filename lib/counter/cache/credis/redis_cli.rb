module Counter
  module Cache
    module Credis
      class RedisCli

        def initialize
          config = YAML.load_file("./config/redis.yml")[Rails.env]
          if config
            @redis ||= Redis.new(:host => config['redis_host'], :port => config['redis_port'],
                                namespace: config['redis_namespace'], :db => config['redis_db'])
          else
            @redis ||= Redis.new
          end
        end

        def method_missing(meth, *args, &blk)
          @redis.send(meth, *args,  &blk)
        end

      end
    end
  end
end