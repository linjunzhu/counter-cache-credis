module Counter
  module Cache
    module Credis
      class RedisCli

        config = YAML.load_file("./config/redis.yml")[Rails.env]

        if config
          REDISCLI = Redis.new(:host => config['redis_host'], :port => config['redis_port'],
                              namespace: config['redis_namespace'], :db => config['redis_db'])
        else
          REDISCLI = Redis.new
        end

        def method_missing(meth, *args, &blk)
          REDISCLI.send(meth, *args,  &blk)
        end

      end
    end
  end
end