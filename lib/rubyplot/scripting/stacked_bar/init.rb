class Rubyplot::StackedBar < Rubyplot::Bar
  #
  # A stacked bar graph (or stacked bar chart) is a chart that uses bars to show
  # comparisons between categories of data, but with ability to break down and
  # compare parts of a whole. Each bar in the chart represents a whole, and
  # segments in the bar represent different parts or categories of that whole.
  #
  # ==== Example
  #
  # plot = Rubyplot::StackedBar.new(400)
  #
  # @datasets = [
  #   [:Car, [25, 36, 86, 39]],
  #   [:Bus, [80, 54, 67, 54]],
  #   [:Train, [22, 29, 35, 38]]
  # ]
  #
  # plot.title = 'Stacked Bar'
  # plot.labels = {
  #   0 => '10',
  #   1 => '15',
  #   2 => '20',
  #   3 => '30'
  # }
  # @datasets.each do |data|
  #   plot.data(data[0], data[1])
  # end
  # plot.write('stacked_bar.png')
  #
  def initialize(*)
    super
    @geometry = Rubyplot::StackedBarGeometry.new
  end
end
