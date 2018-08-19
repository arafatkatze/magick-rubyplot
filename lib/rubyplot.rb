require 'rubygems'
require 'rmagick'
require 'bigdecimal'

require 'rubyplot/artist/colorConstants'
# External GR Ruby Extension
require 'grruby/grruby'
require 'grruby/tasks/gr_function_classes'

require 'rubyplot/scripting_gr/scripting_backends/gr/plots'
require 'rubyplot/scripting_gr/scripting_backends/gr/plot/bar'
require 'rubyplot/scripting_gr/scripting_backends/gr/plot/scatter'
require 'rubyplot/scripting_gr/figure'
require 'rubyplot/scripting_gr/scripting_backends/gr/gr_backend'
require 'rubyplot/scripting_gr/scripting_backends/gr/plotspace'
require 'rubyplot/scripting_gr/scripting_backends/gr/subplot'

# SubPlots
require 'rubyplot/artist/subplots'

# Artist Layer Base
require 'rubyplot/artist/constantsAndAttributes'
require 'rubyplot/artist/geometry'
require 'rubyplot/artist/initialize'
require 'rubyplot/artist/data'
require 'rubyplot/artist/artist'
require 'rubyplot/artist/math'
require 'rubyplot/artist/themes'
require 'rubyplot/artist/magick'
require 'rubyplot/artist/theme_constants'

# Dot Plot
require 'rubyplot/scripting/dot/dot'

# Bar Plot
require 'rubyplot/scripting/bar/bar'
require 'rubyplot/scripting/bar/geometry'
require 'rubyplot/scripting/bar/data_conversion'

# Line Plot
require 'rubyplot/scripting/line/data'
require 'rubyplot/scripting/line/draw'
require 'rubyplot/scripting/line/dotrender'
require 'rubyplot/scripting/line/geometry'

# Scatter
require 'rubyplot/scripting/scatter/scatter'
require 'rubyplot/scripting/scatter/constant'
require 'rubyplot/scripting/scatter/data'
require 'rubyplot/scripting/scatter/init'
require 'rubyplot/scripting/scatter/geometry'

# Bubble
require 'rubyplot/scripting/bubble/geometry'
require 'rubyplot/scripting/bubble/init'
require 'rubyplot/scripting/bubble/draw'
require 'rubyplot/scripting/bubble/data'

# Stacked Bar
require 'rubyplot/scripting/stacked_bar/geometry'
require 'rubyplot/scripting/stacked_bar/data'
require 'rubyplot/scripting/stacked_bar/draw'
require 'rubyplot/scripting/stacked_bar/init'

# Area
require 'rubyplot/scripting/area/geometry'
require 'rubyplot/scripting/area/area'

# Version
require 'rubyplot/version'
# Backend
