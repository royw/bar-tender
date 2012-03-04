require "rubygems"
require "bundler/setup"

require "rack"
require "rack/test"
require "rspec"
require 'json'

require_relative('../../app')

Ramaze.setup_dependencies
Ramaze::Log.level = Logger::ERROR

def app
  Rack::Lint.new(Ramaze.middleware)
end

World(Rack::Test::Methods)

