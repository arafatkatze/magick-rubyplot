class Rubyplot::Bubble < Rubyplot::Scatter
  # Rubyplot::Bubble takes the same parameters as the Rubyplot::Bubble graph
  #
  # ==== Example
  # g = Rubyplot::Bubble.new
  #
  def initialize(*)
    super
    @all_colors_array = Magick.colors
    @plot_colors = []
    @z_data = []
  end
end
