# frozen_string_literal: true

require 'sequel'

module SinatraApp
  class Model
    def initialize
      db
    end
    def db
      return Thread.current[:application_db] if Thread.current[:application_db]
      ENV['RACK_ENV'] = 'development' unless ENV['RACK_ENV']
      config ||= YAML.load_file(File.dirname(__FILE__) + '/../../config.yml')
      db_config = ENV['RACK_ENV']
      dsn = config[db_config]['dsn']
      raise 'Missing db.dsn in configuration. Please set config.yml' unless dsn
      client = Sequel.connect(dsn)
      Thread.current[:application_db] = client
      client
    end
  end
end
