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
require_relative('../../app')

# == Synopsis
# Various extensions to the Object class
# Note, uses the Module.my_extension method to only add the method if
# it doesn't already exist.
class Object
  unless Object.respond_to?('blank?')
    # Is the object nil or empty?
    # return [TrueClass|FalseClass] asserted if object is nil or empty
    def blank?
      result = nil?
      unless result
        if respond_to? 'empty?'
          if respond_to? 'strip'
            result = strip.empty?
          else
            if respond_to? 'compact'
              result = compact.empty?
            else
              result = empty?
            end
          end
        end
      end
      result
    end
  end
end


Ramaze.setup_dependencies
Ramaze::Log.level = Logger::ERROR

def app
  Rack::Lint.new(Ramaze.middleware)
end

World(Rack::Test::Methods)

