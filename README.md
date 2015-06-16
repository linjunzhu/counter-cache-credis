# Counter::Cache::CRedis

Set a counter for model through redis in order to improve perfomance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'counter-cache-credis'
gem 'redis'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install counter-cache-redis

## Usage

### Init

```ruby
rails g redis_config
```
It will create `config/redis.yml`

```ruby
# redis.yml
redis: &redis
  redis_port: 6379
  redis_namespace: 'redis'
  redis_db: 0

test:
  <<: *redis
  redis_host: 'localhost'

development:
  <<: *redis
  redis_host: 'localhost'

production:
  <<: *redis
  redis_host: 'localhost'

```

### Use

```ruby
class Student < ActiveRecord::Base
    counter_cache_redis
end
```
```ruby
student = Student.first
# It will increase itself by one
student.increase_counter
# It will reduce itself by one
student.reduce_counter
# get views_count through redis
student.get_views_count_cache
```

### Configure
```ruby
class Student < ActiveRecord::Base
  # select custom column
  counter_cache_redis column: :hello_count
end
```
```ruby
class Student < ActiveRecord::Base
  # When cache of redis is bigger than 50, it will write to db and refresh redis
  # default is 20
  counter_cache_redis delay: 50
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/counter-cache-redis/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
