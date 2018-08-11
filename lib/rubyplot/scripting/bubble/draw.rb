class Rubyplot::Bubble < Rubyplot::Scatter
  def draw
    super

    # Check to see if more than one datapoint was given. NaN can result otherwise.
    @x_increment = @geometry.column_count > 1 ? (@graph_width / (@geometry.column_count - 1).to_f) : @graph_width

    @geometry.norm_data.each_with_index do |data_row, data_row_index|
      data_row[DATA_VALUES_INDEX].each_with_index do |data_point, index|
        @d = @d.fill @plot_colors[data_row_index]
        x_value = data_row[DATA_VALUES_X_INDEX][index]
        next if data_point.nil? || x_value.nil?

        new_x = get_x_coord(x_value, @graph_width, @graph_left)
        new_y = @graph_top + (@graph_height - data_point * @graph_height)

        # Reset each time to avoid thin-line errors
        @d = @d.stroke_opacity 1.0
        @d.fill_opacity(0.3)
        @d.fill_color(@plot_colors[data_row_index])
        @d = @d.stroke_width @stroke_width || clip_value_if_greater_than(@columns / (@geometry.norm_data.first[1].size * 4), 5.0)

        circle_radius = 2 * @z_data[data_row_index][index]
        @d = @d.circle(new_x, new_y, new_x - circle_radius, new_y)
      end
    end
    @d.draw(@base_image)
  end
end
