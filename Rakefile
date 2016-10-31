# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new

task default: [:test]

# bundle exec rake test
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.ruby_opts = ['-r "./test/test_helper"'] if ENV['COVERRAGE']
  t.test_files = FileList['test/**/test_*.rb']
  t.warning = false
  t.verbose = false
end

# RACK_ENV={test|development|production} bundle exec rake db:migrate
namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_t, args|
    require 'sequel'
    require 'yaml'
    config ||= YAML.load_file('config.yml')
    db_config = ENV['RACK_ENV']
    dsn = config[db_config]['dsn']

    Sequel.extension :migration
    db = Sequel.connect(dsn)
    if args[:version]
      puts "Migrating to version #{arg[:version]}"
      Sequel::Migrator.run(db, 'migrations', target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, 'migrations')
    end
  end
end
