module Rubyplot
  class Artist
    include Magick
    # You can set a theme manually. Assign a hash to this method before you
    # send your data. This permits you to set a background color and also
    # customize the background color to make it look prettier.
    # Aside from that we could also have a feature to draw on a background image
    # So later adding prebuilt background images to draw upon would also be
    # possible.
    #
    #  graph.theme = {
    #    :marker_color => 'blue',
    #    :background_colors => ['black', 'grey', :top_bottom]
    #  }
    #
    def theme=(options)
      reset_themes
      defaults = {
        marker_color: 'white',
        font_color: 'black',
        background_image: nil
      }
      @geometry.theme_options = defaults.merge options
      @marker_color = @geometry.theme_options[:marker_color]
      @font_color = @geometry.theme_options[:font_color] || @marker_color
      @base_image = render_gradiated_background(@geometry.theme_options[:background_colors][0], @geometry.theme_options[:background_colors][1], @geometry.theme_options[:background_direction])
    end

    # Resets the themes to defaults.
    def reset_themes
      @d = Draw.new
      # Scale down from defaut scale to scale used to calculate drawing.
      @d = @d.scale(@scale, @scale)
    end

    def scale(value)
      value * @scale
    end
  end
end
