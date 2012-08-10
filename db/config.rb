require 'sequel'
require 'fileutils'
module Database
  DB_DIR = File.expand_path('data', File.dirname(__FILE__))
  FileUtils.mkdir_p DB_DIR
  def self.url(mode)
    case mode
    when :dev
      "sqlite://#{DB_DIR}/bar-tender-dev.db"
    when :live
      "sqlite://#{DB_DIR}/bar-tender-live.db"
    when :test
      "sqlite://#{DB_DIR}/bar-tender-test.db"
    else
      raise "Unsupported runtime mode (Ramaze.options.mode): #{mode.inspect}"
    end
  end
end


