class Rubyplot::StackedBar < Rubyplot::Bar
  def construct_colors_array
    return unless @plot_colors.empty?
    0.upto(@norm_data.size - 1) do |_i|
      @plot_colors.push(@all_colors_array[rand(@all_colors_array.size)].name)
    end
  end

  def set_colors_array(color_array)
    @plot_colors = color_array
  end

  def set_spacings
    # Setup spacing.
    #
    # Columns sit stacked.
    @bar_spacing ||= 0.9
    @segment_spacing ||= 1
    @bar_width = @graph_width / @column_count.to_f
    @padding = (@bar_width * (1 - @bar_spacing)) / 2
  end

  # Draws a bar graph, but multiple sets are stacked on top of each other.
  # Modified drawing feature of the bar graph with multiple bar graphs
  # stacked on top of each other.
  def draw
    max_stack_height
    setup_drawing
    construct_colors_array
    draw_legend
    draw_line_markers!
    draw_title
    draw_axis_labels
    return unless @has_data

    set_spacings
    @d = @d.stroke_opacity 0.0
    height = Array.new(@column_count, 0)

    @norm_data.each_with_index do |data_row, _row_index|
      data_row[DATA_VALUES_INDEX].each_with_index do |data_point, point_index|
        @d = @d.fill @plot_colors[_row_index]

        # Calculate center based on bar_width and current row
        label_center = @graph_left + (@bar_width * point_index) + (@bar_width * @bar_spacing / 2.0)
        draw_label(label_center, point_index)

        next if data_point == 0
        # Use incremented x and scaled y
        left_x = @graph_left + (@bar_width * point_index) + @padding
        left_y = @graph_top + (@graph_height -
                               data_point * @graph_height -
                               height[point_index]) + @segment_spacing
        right_x = left_x + @bar_width * @bar_spacing
        right_y = @graph_top + @graph_height - height[point_index] - @segment_spacing

        # update the total height of the current stacked bar
        height[point_index] += (data_point * @graph_height)

        # Draw the rectangle
        @d = @d.rectangle(left_x, left_y, right_x, right_y)
      end
    end

    @d.draw(@base_image)
  end
end
