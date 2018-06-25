class Rubyplot::Line < Rubyplot::Artist
  # Allow for reference lines ( which are like baseline ... just allowing for more & on both axes )
  attr_accessor :reference_lines
  attr_accessor :reference_line_default_color
  attr_accessor :reference_line_default_width

  # Allow for vertical marker lines
  attr_accessor :show_vertical_markers

  # Dimensions of lines and dots; calculated based on dataset size if left unspecified
  attr_accessor :line_width
  attr_accessor :dot_radius

  # default is a circle, other options include square
  attr_accessor :dot_style

  # Hide parts of the graph to fit more datapoints, or for a different appearance.
  attr_accessor :hide_dots, :hide_lines

  # accessors for support of xy data
  attr_accessor :minimum_x_value
  attr_accessor :maximum_x_value
end
