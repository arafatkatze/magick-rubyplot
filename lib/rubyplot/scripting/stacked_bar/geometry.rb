module Rubyplot
  class StackedBarGeometry < Rubyplot::ArtistGeometry
    # Array for all the colors supported by RMagick
    attr_accessor :all_colors_array

    # Array of colors to be used by the plot labels(instance variable)
    attr_accessor :plot_colors

    # Spacing factor applied between bars
    attr_accessor :bar_spacing

    # Pixel offsets for geometry calculations
    attr_accessor :graph_width, :bar_width, :padding

    # Number of pixels between bar segments
    attr_accessor :segment_spacing, :column_count

    def initialize(*)
      super
      @all_colors_array = Magick.colors
      @plot_colors = []
    end
  end
end
