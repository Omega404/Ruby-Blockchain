require './test/BlockChainTest'
require "bundler/gem_tasks"
require "rake/testtask"
Rake::TestTask.new do |t|
    t.test_files = FileList['test/*Test.rb']
end
desc "Run tests"

task default: :test