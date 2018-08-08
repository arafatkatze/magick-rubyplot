module Rubyplot
  class BubbleGeometry < Rubyplot::ScatterGeometry
    attr_accessor :all_colors_array
    attr_accessor :z_data
    attr_accessor :plot_colors

    def initialize
      super
      @all_colors_array = Magick.colors
      @plot_colors = []
      @z_data = []
    end
  end
end
