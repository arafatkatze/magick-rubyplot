class Rubyplot::Scatter < Rubyplot::Artist
  def draw
    super
    return unless @geometry.has_data

    # Check to see if more than one datapoint was given. NaN can result otherwise.
    @x_increment = @geometry.column_count > 1 ? (@graph_width / (@geometry.column_count - 1).to_f) : @graph_width

    @geometry.norm_data.each_with_index do |data_row, row_num|
      data_row[DATA_VALUES_INDEX].each_with_index do |data_point, index|
        @d = @d.fill @plot_colors[row_num]
        x_value = data_row[DATA_VALUES_X_INDEX][index]
        next if data_point.nil? || x_value.nil?

        new_x = get_x_coord(x_value, @graph_width, @graph_left)
        new_y = @graph_top + (@graph_height - data_point * @graph_height)

        # Reset each time to avoid thin-line errors
        @d = @d.stroke_opacity 1.0
        @d = @d.stroke_width @geometry.stroke_width || clip_value_if_greater_than(@columns / (@geometry.norm_data.first[1].size * 4), 5.0)

        circle_radius = @geometry.circle_radius || clip_value_if_greater_than(@columns / (@geometry.norm_data.first[1].size * 2.5), 5.0)
        @d = @d.circle(new_x, new_y, new_x - circle_radius, new_y)
      end
    end

    @d.draw(@base_image)
  end

  protected

  def draw_line_markers!
    # do all of the stuff for the horizontal lines on the y-axis
    super
    return if @geometry.hide_line_markers
    @d = @d.stroke_antialias false

    if @geometry.x_axis_increment.nil?
      # TODO: Do the same for larger numbers...100, 75, 50, 25
      if @geometry.marker_x_count.nil?
        (3..7).each do |lines|
          if @x_spread % lines == 0.0
            @geometry.marker_x_count = lines
            break
          end
        end
        @geometry.marker_x_count ||= 4
      end
      @x_increment = @x_spread > 0 ? (@x_spread / @geometry.marker_x_count) : 1
      unless @geometry.disable_significant_rounding_x_axis
        @x_increment = significant(@x_increment)
      end
    else
      # TODO: Make this work for negative values
      @geometry.maximum_x_value = [@geometry.maximum_value.ceil, @geometry.x_axis_increment].max
      @geometry.minimum_x_value = @geometry.minimum_x_value.floor
      calculate_spread
      normalize(true)

      @geometry.marker_count = (@x_spread / @geometry.x_axis_increment).to_i
      @x_increment = @geometry.x_axis_increment
    end
    @geometry.increment_x_scaled = @graph_width.to_f / (@x_spread / @x_increment)

    # Draw vertical line markers and annotate with numbers
    (0..@geometry.marker_x_count).each do |index|
      # TODO: Fix the vertical lines, and enable them by default. Not pretty when they don't match up with top y-axis line
      if @geometry.enable_vertical_line_markers
        x = @graph_left + @graph_width - index.to_f * @geometry.increment_x_scaled
        @d = @d.stroke(@marker_color)
        @d = @d.stroke_width 1
        @d = @d.line(x, @graph_top, x, @graph_bottom)
      end

      next if @geometry.hide_line_numbers
      marker_label = index * @x_increment + @geometry.minimum_x_value.to_f
      y_offset = @graph_bottom + (@geometry.x_label_margin || LABEL_MARGIN)
      x_offset = get_x_coord(index.to_f, @geometry.increment_x_scaled, @graph_left)

      @d.fill = @font_color
      @d.font = @font if @font
      @d.stroke('transparent')
      @d.pointsize = scale_fontsize(@marker_font_size)
      @d.gravity = NorthGravity
      @d.rotation = -90.0 if @geometry.use_vertical_x_labels
      @d = @d.scale_annotation(@base_image,
                               1.0, 1.0,
                               x_offset, y_offset,
                               vertical_label(marker_label, @x_increment), @scale)
      @d.rotation = 90.0 if @geometry.use_vertical_x_labels
    end

    @d = @d.stroke_antialias true
  end

  def label(value, increment)
    if @geometry.y_axis_label_format
      @geometry.y_axis_label_format.call(value)
    else
      super
    end
  end

  def vertical_label(value, increment)
    if @geometry.x_axis_label_format
      @geometry.x_axis_label_format.call(value)
    else
      label(value, increment)
    end
  end

  private

  def get_x_coord(x_data_point, width, offset)
    x_data_point * width + offset
  end
end
