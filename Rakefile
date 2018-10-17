require 'rubygems'
require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rake/clean'
require 'rspec/core/rake_task'
require 'rake/extensiontask'

gemspec = eval(IO.read('rubyplot.gemspec'))

RSpec::Core::RakeTask.new(:spec)

task :pry do |_task|
  cmd = ['pry', "-r './lib/rubyplot.rb' "]
  run(*cmd)
end

def run(*cmd)
  sh(cmd.join(' '))
end

task default: :spec

ext_name = 'grruby'
Rake::ExtensionTask.new(ext_name, gemspec) do |ext|
  ext.ext_dir = "ext/#{ext_name}"
  ext.source_pattern = '**/*.{c,h}'
end
