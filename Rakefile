# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "bar-tender #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require_relative 'db/config'
namespace 'db' do
  desc 'Run database migrations'
  task :migrate, :mode do |t, args|
    cmd = "sequel -m db/migrations #{Database.url(mode(args[:mode]))}"
    puts cmd
    puts `#{cmd}`
  end

  desc 'Zap the database my running all the down migrations'
  task :zap, [:mode] do |t, args|
    cmd = "sequel -m db/migrations -M 0 #{Database.url(mode(args[:mode]))}"
    puts cmd
    puts `#{cmd}`
  end

  desc 'Reset the database then run the migrations'
  task :reset, [:mode] => [:zap, :migrate]
end

def mode(arg)
  mode = arg
  if mode.nil? || mode.strip.empty?
    mode = 'dev'
  end
  mode.to_sym
end