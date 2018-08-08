class Rubyplot::Area < Rubyplot::Artist
  def initialize(*)
    super
    @sorted_drawing = true
    @all_colors_array = Magick.colors
    @plot_colors = []
  end

  def construct_colors_array
    0.upto(@geometry.norm_data.size - 1) do |_i|
      @plot_colors.push(@all_colors_array[rand(@all_colors_array.size)].name)
    end
  end

  def draw
    setup_drawing
    construct_colors_array
    draw_legend
    draw_line_markers!
    draw_title
    draw_axis_labels

    return unless @geometry.has_data

    @x_increment = @graph_width / (@geometry.column_count - 1).to_f
    @d = @d.stroke 'transparent'

    @geometry.norm_data.each_with_index do |data_row, i|
      poly_points = []
      prev_x = prev_y = 0.0
      @d = @d.fill @plot_colors[i]

      data_row[DATA_VALUES_INDEX].each_with_index do |data_point, index|
        # Use incremented x and scaled y
        new_x = @graph_left + (@x_increment * index)
        new_y = @graph_top + (@graph_height - data_point * @graph_height)

        poly_points << new_x
        poly_points << new_y

        draw_label(new_x, index)

        prev_x = new_x
        prev_y = new_y
      end

      # Add closing points, draw polygon
      poly_points << @graph_right
      poly_points << @graph_bottom - 1
      poly_points << @graph_left
      poly_points << @graph_bottom - 1

      @d = @d.polyline(*poly_points)
    end

    @d.draw(@base_image)
  end
end
