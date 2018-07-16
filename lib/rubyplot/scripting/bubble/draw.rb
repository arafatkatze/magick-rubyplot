class Rubyplot::Bubble < Rubyplot::Scatter
  def construct_colors_array
    return unless @plot_colors.empty?
    0.upto(@norm_data.size - 1) do |_i|
      @plot_colors.push(@all_colors_array[rand(@all_colors_array.size)].name)
    end
  end

  def draw_line_markers
    super
  end

  def get_colors_array
    @plot_colors
  end

  def set_colors_array(color_array)
    @plot_colors = color_array
  end

  def draw
    setup_drawing
    construct_colors_array
    draw_legend
    draw_line_markers!
    draw_title
    draw_axis_labels

    # Check to see if more than one datapoint was given. NaN can result otherwise.
    @x_increment = @column_count > 1 ? (@graph_width / (@column_count - 1).to_f) : @graph_width

    # ~ if (defined?(@norm_y_baseline)) then
    # ~ level = @graph_top + (@graph_height - @norm_baseline * @graph_height)
    # ~ @d = @d.push
    # ~ @d.stroke_color @baseline_color
    # ~ @d.fill_opacity 0.0
    # ~ @d.stroke_dasharray(10, 20)
    # ~ @d.stroke_width 5
    # ~ @d.line(@graph_left, level, @graph_left + @graph_width, level)
    # ~ @d = @d.pop
    # ~ end

    # ~ if (defined?(@norm_x_baseline)) then
    # ~ end
    @norm_data.each_with_index do |data_row, data_row_index|
      data_row[DATA_VALUES_INDEX].each_with_index do |data_point, index|
        x_value = data_row[DATA_VALUES_X_INDEX][index]
        next if data_point.nil? || x_value.nil?

        new_x = get_x_coord(x_value, @graph_width, @graph_left)
        new_y = @graph_top + (@graph_height - data_point * @graph_height)

        # Reset each time to avoid thin-line errors
        @d = @d.stroke_opacity 1.0
        @d.fill_opacity(0.3)
        @d.fill_color(@plot_colors[data_row_index])
        @d = @d.stroke_width @stroke_width || clip_value_if_greater_than(@columns / (@norm_data.first[1].size * 4), 5.0)

        circle_radius = @z_data[index]
        @d = @d.circle(new_x, new_y, new_x - circle_radius, new_y)
      end
    end
    @d.draw(@base_image)
  end
end
