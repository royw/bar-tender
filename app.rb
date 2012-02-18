# This file contains your application, it requires dependencies and necessary parts of 
# the application.
#
# It will be required from either `config.ru` or `start.rb`
require 'rubygems'
require "bundler/setup"

require 'ramaze'

# Make sure that Ramaze knows where you are
Ramaze.options.roots = [__DIR__]

require 'sequel'

DATA_DIR = __DIR__('data')
FileUtils.mkdir_p DATA_DIR
DATABASE_FILE = "#{DATA_DIR}/bar-tender.db"
DB = Sequel.connect("sqlite://#{DATABASE_FILE}")

# Initialize controllers and models
require __DIR__('model/init')
require __DIR__('controller/init')
