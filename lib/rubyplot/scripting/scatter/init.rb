class Rubyplot::Scatter < Rubyplot::Artist
  # Rubyplot::Scatter takes the same parameters as the Rubyplot::Line graph
  #
  # ==== Example
  #
  # g = Rubyplot::Scatter.new
  #
  def initialize(*)
    super
    @geometry = Rubyplot::ScatterGeometry.new
  end

  def setup_drawing
    @labels = {}

    super

    # Translate our values so that we can use the base methods for drawing
    # the standard chart stuff
    @geometry.column_count = @x_spread
  end
end
