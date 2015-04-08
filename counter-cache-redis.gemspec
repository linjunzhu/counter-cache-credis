# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'counter/cache/redis/version'

Gem::Specification.new do |spec|
  spec.name          = "counter-cache-redis"
  spec.version       = Counter::Cache::Redis::VERSION
  spec.authors       = ["linjunzhu"]
  spec.email         = ["linjunzhugg@gmail.com"]
  spec.summary       = %q{将各种浏览量，点赞数之类的存于缓存}
  spec.description   = %q{将各种浏览量，点赞数之类的存于缓存，这样就不会每次都去 DB 修改}
  spec.homepage      = "linjunzhu.me"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
