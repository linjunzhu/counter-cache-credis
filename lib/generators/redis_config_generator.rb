class RedisConfigGenerator < Rails::Generators::Base
  def create_redis_file
    file_name = 'config/redis.yml'
    unless File.exists?(File.expand_path(file_name))
      p "Creating #{file_name}"
      File.open(file_name, 'w') do |f|
        f.puts "redis: &redis"
        f.puts "  redis_port: 6379"
        f.puts "  redis_namespace: 'redis'"
        f.puts "  redis_db: 0"
        f.puts ""
        f.puts "test: "
        f.puts "  <<: *redis"
        f.puts "  redis_host: 'localhost'"
        f.puts ""
        f.puts "development: "
        f.puts "  <<: *redis"
        f.puts "  redis_host: 'localhost'"
        f.puts ""
        f.puts "production: "
        f.puts "  <<: *redis"
        f.puts "  redis_host: 'localhost'"
      end
    else
      puts "Skipping #{file_name}, it already exists"
    end
  end
end