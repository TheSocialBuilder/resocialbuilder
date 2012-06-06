require 'redis'
require 'redis/objects'

redis = Redis.new(:host => 'localhost', :port => 6379, :db => 0)