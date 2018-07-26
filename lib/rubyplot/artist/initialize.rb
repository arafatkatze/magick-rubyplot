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
      self.theme = Themes::BASIC
    end

    # Set instance variables for this object.
    #
    # Subclasses can override this, call super, then set values separately.
    #
    # This makes it possible to set defaults in a subclass but still allow
    # developers to change this values in their program.
    def initialize_variables
      # Internal for calculations
      @raw_columns = 800.0
      @raw_rows = 800.0 * (@rows / @columns)
      @column_count = 0
      @data = []
      @marker_count = nil
      @maximum_value = @minimum_value = nil
      @has_data = false
      @increment = nil
      @labels = {}
      @label_formatting = nil
      @labels_seen = {}
      @sort = false
      @sorted_drawing = false
      @title = nil
      @title_font = nil

      @scale = @columns / @raw_columns

      vera_font_path = File.expand_path('Vera.ttf', ENV['MAGICK_FONT_PATH'])
      @font = File.exist?(vera_font_path) ? vera_font_path : nil
      @bold_title = true

      @marker_font_size = 21.0
      @legend_font_size = 20.0
      @title_font_size = 36.0

      @top_margin = @bottom_margin = @left_margin = @right_margin = DEFAULT_MARGIN
      @legend_margin = LEGEND_MARGIN
      @title_margin = TITLE_MARGIN

      @legend_box_size = 20.0

      @no_data_message = 'No Data'

      @hide_line_markers = @hide_legend = @hide_title = @hide_line_numbers = @legend_at_bottom = @show_labels_for_bar_values = false
      @center_labels_over_point = true
      @has_left_labels = false
      @label_stagger_height = 0
      @label_max_size = 0
      @label_truncation_style = :absolute
    end
  end
end
