require "bundler/gem_tasks"
require 'rake/testtask'

desc 'executes all tests'
task :test => %w(test:unit)

namespace :test do
  desc 'executes all unit tests'
  Rake::TestTask.new(:unit) do |t|
    t.libs << 'test'
    t.test_files = FileList['test/unit/**/*_test.rb']
    t.verbose = true
    t.options = '-v'
  end


end

