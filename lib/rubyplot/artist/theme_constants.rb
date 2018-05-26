module Ruplot
  # This module is a set of constants to define themes constant variables
  # to be used with the RMagick code to make beautiful looking plots.
  module Themes
    # The standard presentation scheme for the software.
    BASIC = {
      colors: [
        '#FDD84E',  # yellow
        '#8A6EAF',  # purple
        '#EFAA43',  # orange
        '#6886B4',  # blue
        '#72AE6E',  # green
        '#D1695E',  # red
        'white'
      ],
      marker_color: 'white',
      font_color: 'white',
      background_colors: %w[black #4a465a]
    }.freeze
  end
end
