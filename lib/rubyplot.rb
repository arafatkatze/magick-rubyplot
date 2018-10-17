# Common Dependencies
require 'rubygems'
require 'rmagick'
require 'bigdecimal'

module Rubyplot
  class << self
    def backend
      @backend || :magick
    end

    attr_writer :backend
  end
end

require 'rubyplot/version'
require 'rubyplot/color_constants'
require 'grruby/grruby'
require 'magick/magick'

require 'common/figure/figure'
require 'common/figure/backend_switch'

