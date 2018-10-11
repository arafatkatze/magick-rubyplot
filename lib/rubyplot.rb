# Common Dependencies
require 'rubygems'
require 'rmagick'
require 'bigdecimal'

# Color constants used by GR Plot and Magick Plot
require 'common/colorConstants'

#
#
# GR PLOT FILES::START
#
#

# GR Ruby C Extension Files
require 'grruby/grruby'
require 'grruby/tasks/gr_function_classes'
# Scripting Layer files of GR Plot.
require 'grruby/scripting/plots'
require 'grruby/scripting/plot/bar'
require 'grruby/scripting/plot/scatter'
require 'grruby/scripting/plot/stacked_bar'
require 'common/figure/figure'
require 'common/figure/backend_switch'
require 'grruby/scripting/plotspace'
require 'grruby/scripting/subplot'

#
#
# GR Plot Files::END
#
#

#
#
# Magick Plot Files::START
#
#

# SubPlots
require 'magick/artist/subplots'

# Artist Layer Base
require 'magick/artist/constantsAndAttributes'
require 'magick/artist/geometry'
require 'magick/artist/initialize'
require 'magick/artist/data'
require 'magick/artist/artist'
require 'magick/artist/math'
require 'magick/artist/themes'
require 'magick/artist/magick'
require 'magick/artist/theme_constants'

# Dot Plot
require 'magick/scripting/dot/dot'

# Bar Plot
require 'magick/scripting/bar/bar'
require 'magick/scripting/bar/geometry'
require 'magick/scripting/bar/data_conversion'

# Line Plot
require 'magick/scripting/line/data'
require 'magick/scripting/line/draw'
require 'magick/scripting/line/dotrender'
require 'magick/scripting/line/geometry'

# Scatter
require 'magick/scripting/scatter/scatter'
require 'magick/scripting/scatter/constant'
require 'magick/scripting/scatter/data'
require 'magick/scripting/scatter/init'
require 'magick/scripting/scatter/geometry'

# Bubble
require 'magick/scripting/bubble/geometry'
require 'magick/scripting/bubble/init'
require 'magick/scripting/bubble/draw'
require 'magick/scripting/bubble/data'

# Stacked Bar
require 'magick/scripting/stacked_bar/geometry'
require 'magick/scripting/stacked_bar/data'
require 'magick/scripting/stacked_bar/draw'
require 'magick/scripting/stacked_bar/init'

# Area
require 'magick/scripting/area/geometry'
require 'magick/scripting/area/area'

#
#
# Magick Plot Files::END
#
#

# Version
require 'common/version'
