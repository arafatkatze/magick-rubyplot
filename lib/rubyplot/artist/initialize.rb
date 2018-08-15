module Rubyplot
  class Artist
    # If one numerical argument is given, the graph is drawn at 4/3 ratio
    # according to the given width (800 results in 800x600, 400 gives 400x300,
    # etc.).
    #
    # Or, send a geometry string for other ratios ('800x400', '400x225').
    #
    # Looks for Bitstream Vera as the default font. Expects an environment var
    # of MAGICK_FONT_PATH to be set. (Uses RMagick's default font otherwise.)
    def initialize(target_width = DEFAULT_TARGET_WIDTH)
      if Numeric === target_width
        @columns = target_width.to_f
        @rows = target_width.to_f * 0.75
      else
        geometric_width, geometric_height = target_width.split('x')
        @columns = geometric_width.to_f
        @rows = geometric_height.to_f
      end
      @geometry = Rubyplot::ArtistGeometry.new
      initialize_variables

      reset_themes
      self.theme = Themes::CLASSIC_WHITE
    end

    # Set instance variables for this object.
    #
    # Subclasses can override this, call super, then set values separately.
    #
    # This makes it possible to set defaults in a subclass but still allow
    # developers to change this values in their program.
    def initialize_variables
      # Internal for calculations
      @data = []

      @raw_rows = 800.0 * (@rows / @columns)
      @labels = {}
      @sort = false
      @title = nil
      @title_font = nil

      @scale = @columns / @geometry.raw_columns

      vera_font_path = File.expand_path('Vera.ttf', ENV['MAGICK_FONT_PATH'])
      @font = File.exist?(vera_font_path) ? vera_font_path : nil

      @marker_font_size = 21.0
      @legend_font_size = 20.0
      @title_font_size = 36.0

      @legend_margin = LEGEND_MARGIN
      @title_margin = TITLE_MARGIN

      @legend_box_size = 20.0

      @label_stagger_height = 0
      @label_max_size = 0
      @label_truncation_style = :absolute
      @plot_colors = []
    end
  end
end
