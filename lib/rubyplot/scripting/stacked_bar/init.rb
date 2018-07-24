class Rubyplot::StackedBar < Rubyplot::Bar
  # A stacked bar graph (or stacked bar chart) is a chart that uses bars to show
  # comparisons between categories of data, but with ability to break down and
  # compare parts of a whole. Each bar in the chart represents a whole, and
  # segments in the bar represent different parts or categories of that whole.
  #
  # ==== Example
  #
  # g = Rubyplot::Scatter.new
  #
  def initialize(*)
    super
    @all_colors_array = Magick.colors
    @plot_colors = []
  end

  # Spacing factor applied between bars
  attr_accessor :bar_spacing

  # Number of pixels between bar segments
  attr_accessor :segment_spacing
end
