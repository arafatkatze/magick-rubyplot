module Rubyplot
  # This module is a set of constants to define themes constant variables
  # to be used with the RMagick code to make beautiful looking plots.
  module Themes
    # A color scheme similar to the popular presentation software.
    BASIC = {
      marker_color: 'white', # The color of the marker used to make marker lines on plot.
      font_color: 'white', # Font Color used to write on the plot.
      background_colors: %w[black #4a465a], # The Background colors that form the gradient
      label_colors: %w[yellow green blue red maroon grey #FF6A6A #FFAEB9 #EE82EE #00E5EE #00FF7F #C0FF3E #FFA500 #FFE4E1 #BDBDBD #8B2500 #436EEE #DC143C]
    }.freeze

    TRACKS = {
      marker_color: 'white',
      font_color: 'white',
      background_colors: %w[#0083a3 #0083a3]
    }.freeze

    OREO = {
      marker_color: 'white',
      font_color: 'white',
      background_colors: %w[#ff47a4 #ff1f81]
    }.freeze

    RITA = {
      marker_color: 'black',
      font_color: 'black',
      background_colors: %w[#d1edf5 white]
    }.freeze

    # Plain White back ground with no gradient.
    CLASSIC_WHITE = {
      marker_color: 'black',
      font_color: 'black',
      background_colors: %w[white white]
    }.freeze
  end
end
