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

