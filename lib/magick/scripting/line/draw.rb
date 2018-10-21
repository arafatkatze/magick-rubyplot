# This class helps draw line graphs for both "y axis data" and for "x-y axis data".
module Rubyplot
  class Line < Artist
    # Dimensions of lines and dots; calculated based on dataset size if left unspecified
    attr_accessor :line_width
    attr_accessor :dot_radius
    # Call with target pixel width of graph (800, 400, 300), and/or 'false' to omit lines (points only).
    #  g = Rubyplot::Line.new(400) # 400px wide with lines.
    #
    #  g = Rubyplot::Line.new(400, false) # 400px wide, no lines
    #
    #  g = Rubyplot::Line.new(false) # Defaults to 800px wide, no lines
    def initialize(*args)
      raise ArgumentError, 'Wrong number of arguments' if args.length > 2
      if args.empty? || (!(Numeric === args.first) && !(String === args.first))
        super()
      else
        super args.shift # TODO: Figure out a better alternative here.
      end

      @geometry = Rubyplot::LineGeometry.new
    end

    # Get the value if somebody has defined it.
    def baseline_value
      @geometry.reference_lines[:baseline][:value] if @geometry.reference_lines.key?(:baseline)
    end

    # Set a value for a baseline reference line.
    def baseline_value=(new_value)
      @geometry.reference_lines[:baseline] ||= {}
      @geometry.reference_lines[:baseline][:value] = new_value
    end

    def draw_reference_line(reference_line, left, right, top, bottom)
      @d = @d.push
      @d.stroke_color(@reference_line_default_color)
      @d.fill_opacity 0.0
      @d.stroke_dasharray(10, 20)
      @d.stroke_width(reference_line[:width] || @reference_line_default_width)
      @d.line(left, top, right, bottom)
      @d = @d.pop
    end

    def draw
      super
      return unless @geometry.has_data

      # Check to see if more than one datapoint was given. NaN can result otherwise.
      @x_increment = @geometry.column_count > 1 ? (@graph_width / (@geometry.column_count - 1).to_f) : @graph_width

      @geometry.norm_data.each_with_index do |data_row, row_num|
        # Initially the previous x,y points are nil and then
        # they are set with values.
        prev_x = prev_y = nil

        @one_point = contains_one_point_only?(data_row)

        @d = @d.fill @plot_colors[row_num]
        data_row[DATA_VALUES_INDEX].each_with_index do |data_point, index|
          x_data = data_row[DATA_VALUES_X_INDEX]
          if x_data.nil?
            new_x = @graph_left + (@x_increment * index)
            draw_label(new_x, index)
          else
            new_x = get_x_coord(x_data[index], @graph_width, @graph_left)
            @labels.each do |label_pos, _|
              draw_label(@graph_left + ((label_pos - @geometry.minimum_x_value) * @graph_width) / (@geometry.maximum_x_value - @geometry.minimum_x_value), label_pos)
            end
          end
          unless data_point # we can't draw a line for a null data point, we can still label the axis though
            prev_x = prev_y = nil
            next
          end
          new_y = @graph_top + (@graph_height - data_point * @graph_height)
          # Reset each time to avoid thin-line errors.
          #  @d = @d.stroke data_row[DATA_COLOR_INDEX]
          # @d = @d.fill data_row[DATA_COLOR_INDEX]
          @d = @d.stroke_opacity 1.0
          @d = @d.stroke_width line_width ||
                               clip_value_if_greater_than(@columns / (@geometry.norm_data.first[DATA_VALUES_INDEX].size * 4), 5.0)

          circle_radius = dot_radius ||
                          clip_value_if_greater_than(@columns / (@geometry.norm_data.first[DATA_VALUES_INDEX].size * 2.5), 5.0)

          if !@geometry.hide_lines && !prev_x.nil? && !prev_y.nil?
            @d = @d.line(prev_x, prev_y, new_x, new_y)
          elsif @one_point
            # Show a circle if there's just one_point
            @d = DotRenderers.renderer(@geometry.dot_style).render(@d, new_x, new_y, circle_radius)
          end

          unless @geometry.hide_dots
            @d = DotRenderers.renderer(@geometry.dot_style).render(@d, new_x, new_y, circle_radius)
          end

          prev_x = new_x
          prev_y = new_y
        end
      end

      @d.draw(@base_image)
    end

    # Returns the X co-ordinate of a given data point.
    def get_x_coord(x_data_point, width, offset)
      x_data_point * width + offset
    end
  end
end
