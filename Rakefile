require 'rubygems'
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/clean'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task gem: :build
task :pry do |_task|
  cmd = ['pry', "-r './lib/rubyplot.rb' "]
  run(*cmd)
end

def run(*cmd)
  sh(cmd.join(' '))
end

task default: :spec
