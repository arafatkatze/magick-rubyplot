class Rubyplot::Scatter < Rubyplot::Artist
  # Maximum X Value. The value will get overwritten by the max in the
  # datasets.
  attr_accessor :maximum_x_value

  # Minimum X Value. The value will get overwritten by the min in the
  # datasets.
  attr_accessor :minimum_x_value

  # The number of vertical lines shown for reference
  attr_accessor :marker_x_count

  # TODO: set a proper place for all the attributes.
  # ~ # Draw a dashed horizontal line at the given y value
  # ~ attr_accessor :baseline_y_value

  # ~ # Color of the horizontal baseline
  # ~ attr_accessor :baseline_y_color

  # ~ # Draw a dashed horizontal line at the given y value
  # ~ attr_accessor :baseline_x_value

  # ~ # Color of the horizontal baseline
  # ~ attr_accessor :baseline_x_color

  # Attributes to allow customising the size of the points
  attr_accessor :circle_radius
  attr_accessor :stroke_width

  # Allow disabling the significant rounding when labeling the X axis
  # This is useful when working with a small range of high values (for example, a date range of months, while seconds as units)
  attr_accessor :disable_significant_rounding_x_axis

  # Allow enabling vertical lines. When you have a lot of data, they can work great
  attr_accessor :enable_vertical_line_markers

  # Allow using vertical labels in the X axis (and setting the label margin)
  attr_accessor :x_label_margin
  attr_accessor :use_vertical_x_labels

  # Allow passing lambdas to format labels
  attr_accessor :y_axis_label_format
  attr_accessor :x_axis_label_format
end
