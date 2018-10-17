lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubyplot/version'

Gem::Specification.new do |s|
  s.name = 'magick-rubyplot'
  s.version     = Rubyplot::VERSION
  s.date        = '2018-05-13'
  s.email       = 'arafat.da.khan@gmail.com'
  s.summary     = 'A Plotting gem for Ruby.'
  s.description = 'magick-rubyplot is a Ruby plotting library which produces publication quality figures in a variety of hardcopy formats and interactive environments across platforms.'
  s.authors     = ['Arafat Dad Khan']
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.license     = 'MIT license'
  s.homepage    = 'https://github.com/Arafatk/magick-rubyplot'
  s.extensions  = ['ext/grruby/extconf.rb']

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rake-compiler'
  s.add_dependency 'rmagick',  '>= 2.13.4'
  s.add_development_dependency 'gtk3'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-autotest'
  s.add_development_dependency 'ZenTest'
end
