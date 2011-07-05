require 'bundler'
require 'rake/testtask'
Bundler::GemHelper.install_tasks

task :default => :test

desc 'Run unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end