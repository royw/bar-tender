require 'simplecov'
SimpleCov.start

require "rubygems"
require "bundler/setup"

require "rack"
require "rack/test"
require "rspec"
require 'json'

require 'ramaze'
ENV['Ramaze.options.mode'] = :test.to_s
require_relative('../app')

Ramaze::Log.level = Logger::DEBUG

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Rack::Test::Methods

  def app
    Ramaze.setup_dependencies
    Rack::Lint.new(Ramaze.middleware)
  end
end

