class Rubyplot::Bubble < Rubyplot::Scatter
  # The first parameter is the name of the dataset.  The next two are the
  # x and y axis data points contain in their own array in that respective
  # order. Then the Z axis data points refer to the radius of the bubble plots.
  # The final parameter is the color.
  #
  # Can be called multiple times with different datasets for a multi-valued
  # graph.
  #
  # If the color argument is nil, the next color from the default theme will
  # be used.
  #
  # ==== Parameters to data function
  # name:: String or Symbol containing the name of the dataset.
  # x_data_points:: An Array of x-axis data points.
  # y_data_points:: An Array of y-axis data points.
  # z_data_points:: An Array containing the radius of the data points.
  # color:: The hex string for the color of the dataset.  Defaults to nil.
  #
  #
  # ==== Examples
  # plot = Rubyplot::Bubble.new
  # plot.data(:apples, [-1, 19, -4, -23], [-35, 21, 23, -4], [45, 10, 21, 9])
  # plot.data(:peaches, [20, 30, -6, -3], [-1, 5, -27, -3], [13, 10, 20, 10])
  # plot.write('spec/reference_images/bubble_test_1.png')
  #
  def data(name, x_data_points = [], y_data_points = [], z_data_points = [], color = nil)
    # Call the existing data routine for the y axis data
    data_y(name, y_data_points, z_data_points, color)
    # append the x data to the last entry that was just added in the @data member
    last_elem = @data.length - 1
    @data[last_elem] << x_data_points

    if @geometry.maximum_x_value.nil? && @geometry.minimum_x_value.nil?
      @geometry.maximum_x_value = @geometry.minimum_x_value = x_data_points.first
    end
    @z_data << z_data_points
    x_z_array_sum = [x_data_points, z_data_points].transpose.map { |x| x.reduce(:+) }
    x_z_array_diff = [x_data_points, z_data_points].transpose.map { |x| x.reduce(:-) }

    @geometry.maximum_x_value = x_z_array_sum.max > @geometry.maximum_x_value ?
                        x_z_array_sum.max : @geometry.maximum_x_value
    @geometry.minimum_x_value = x_z_array_sum.min < @geometry.minimum_x_value ?
                        x_z_array_sum.min : @geometry.minimum_x_value

    @geometry.maximum_x_value = x_z_array_diff.max > @geometry.maximum_x_value ?
                        x_z_array_diff.max : @geometry.maximum_x_value
    @geometry.minimum_x_value = x_z_array_diff.min < @geometry.minimum_x_value ?
                        x_z_array_diff.min : @geometry.minimum_x_value
  end

  private

  # Helper function to normalize the data along Y axis.
  def data_y(name, data_points = [], z_data_points, color)
    data_points = Array(data_points) # make sure it's an array
    # TODO: Adding an empty color array which can be developed later
    # to make graphs super customizable with regards to coloring of
    # individual data points.
    @data << [name, data_points, color]
    # Set column count if this is larger than previous column counts
    @geometry.column_count = data_points.length > @geometry.column_count ? data_points.length : @geometry.column_count

    y_z_array_sum = [data_points, z_data_points].transpose.map { |x| x.reduce(:+) }
    y_z_array_diff = [data_points, z_data_points].transpose.map { |x| x.reduce(:-) }
    if @geometry.maximum_value.nil? && @geometry.maximum_value.nil?
      @geometry.maximum_value = @geometry.minimum_value = data_points.first
    end
    @geometry.maximum_value = y_z_array_sum.max > @geometry.maximum_value ?
                        y_z_array_sum.max : @geometry.maximum_value
    @geometry.minimum_value = y_z_array_sum.min < @geometry.minimum_value ?
                        y_z_array_sum.min : @geometry.minimum_value
    @geometry.maximum_value = y_z_array_diff.max > @geometry.maximum_value ?
                        y_z_array_diff.max : @geometry.maximum_value
    @geometry.minimum_value = y_z_array_diff.min < @geometry.minimum_value ?
                        y_z_array_diff.min : @geometry.minimum_value
    @geometry.has_data = true
  end
end
