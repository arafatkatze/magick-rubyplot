class Rubyplot::Scatter < Rubyplot::Artist
  # Rubyplot::Scatter takes the same parameters as the Rubyplot::Line graph
  #
  # ==== Example
  #
  # g = Rubyplot::Scatter.new
  #
  def initialize(*)
    super
    @baseline_x_color = @baseline_y_color = 'red'
    @baseline_x_value = @baseline_y_value = nil
    @circle_radius = nil
    @disable_significant_rounding_x_axis = false
    @enable_vertical_line_markers = false
    @marker_x_count = nil
    @maximum_x_value = @minimum_x_value = nil
    @stroke_width = nil
    @use_vertical_x_labels = false
    @x_axis_label_format = nil
    @x_label_margin = nil
    @y_axis_label_format = nil
  end

  def setup_drawing
    @labels = {}

    super

    # Translate our values so that we can use the base methods for drawing
    # the standard chart stuff
    @column_count = @x_spread
  end
end
