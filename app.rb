# This file contains your application, it requires dependencies and necessary parts of 
# the application.
#
# It will be required from either `config.ru` or `start.rb`
require 'rubygems'
require 'bundler/setup'
require 'ramaze'
require 'rack/accept'
require 'omniauth'

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]

Ramaze::Log.loggers = [Logger.new($stdout)]

Ramaze.middleware! :dev do |m|
  m.use(Rack::Session::Cookie)
  m.use(Rack::Accept)
  m.use OmniAuth::Builder do
    provider :developer
    #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  end
  m.run(Ramaze::AppMap)
end
Ramaze.middleware! :live do |m|
  m.use(Rack::Session::Cookie)
  m.use(Rack::Accept)
  m.use OmniAuth::Builder do
    #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  end
  m.run(Ramaze::AppMap)
end
Ramaze.middleware! :test do |m|
  m.use(Rack::Session::Cookie)
  m.use(Rack::Accept)
  m.use OmniAuth::Builder do
    provider :developer
    #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  end
  m.run(Ramaze::AppMap)
end

# The mode defaults to :dev
mode = ENV['Ramaze.options.mode'] || 'dev'
Ramaze.options.mode = mode.to_sym
puts "Ramaze.options.mode => #{Ramaze.options.mode.inspect}"

require_relative 'db/config'
DB = Sequel.connect(Database.url(Ramaze.options.mode))

# Initialize controllers and models
require __DIR__('model/init')
require __DIR__('controller/init')
