require "rubygems"
require "bundler/setup"

require "rack"
require "rack/test"
require "rspec"
require 'json'

require_relative('../app')

Ramaze.setup_dependencies
Ramaze::Log.level = Logger::ERROR

RSpec.configure do |config|
  config.mock_with :rspec
  config.include Rack::Test::Methods

  def app
    Rack::Lint.new(Ramaze.middleware)
  end
end

