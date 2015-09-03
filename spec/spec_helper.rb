$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'activerecord-jwt'
require 'bundler/setup'

Bundler.require
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
