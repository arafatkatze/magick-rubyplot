class Rubyplot::Bubble < Rubyplot::Scatter
  # Parameters are an array where the first element is the name of the dataset
  # and the value is an array of values to plot.
  #
  # Can be called multiple times with different datasets for a multi-valued
  # graph.
  #
  # Example:
  #   data("Arafat", [95, 45, 78, 89, 88, 76])
  def data_y(name, data_points = [], z_data_points)
    data_points = Array(data_points) # make sure it's an array
    # TODO: Adding an empty color array which can be developed later
    # to make graphs super customizable with regards to coloring of
    # individual data points.
    color = []
    @data << [name, data_points, color]
    # Set column count if this is larger than previous column counts
    @column_count = data_points.length > @column_count ? data_points.length : @column_count

    y_z_array_sum = [data_points, z_data_points].transpose.map { |x| x.reduce(:+) }
    y_z_array_diff = [data_points, z_data_points].transpose.map { |x| x.reduce(:-) }
    if @maximum_value.nil? && @maximum_value.nil?
      @maximum_value = @minimum_value = data_points.first
    end
    @maximum_value = y_z_array_sum.max > @maximum_value ?
                        y_z_array_sum.max : @maximum_value
    @minimum_value = y_z_array_sum.min < @minimum_value ?
                        y_z_array_sum.min : @minimum_value
    @maximum_value = y_z_array_diff.max > @maximum_value ?
                        y_z_array_diff.max : @maximum_value
    @minimum_value = y_z_array_diff.min < @minimum_value ?
                        y_z_array_diff.min : @minimum_value
    @has_data = true
  end

  # The first parameter is the name of the dataset.  The next two are the
  # x and y axis data points contain in their own array in that respective
  # order.  The final parameter is the color.
  #
  # Can be called multiple times with different datasets for a multi-valued
  # graph.
  #
  # If the color argument is nil, the next color from the default theme will
  # be used.
  #
  # ==== Parameters
  # name:: String or Symbol containing the name of the dataset.
  # x_data_points:: An Array of of x-axis data points.
  # y_data_points:: An Array of of y-axis data points.
  # color:: The hex string for the color of the dataset.  Defaults to nil.
  #
  # ==== Exceptions
  # Data points contain nil values::
  #   This error will get raised if either the x or y axis data points array
  #   contains a <tt>nil</tt> value.  The graph will not make an assumption
  #   as how to graph <tt>nil</tt>
  # x_data_points is empty::
  #   This error is raised when the array for the x-axis points are empty
  # y_data_points is empty::
  #   This error is raised when the array for the y-axis points are empty
  # x_data_points.length != y_data_points.length::
  #   Error means that the x and y axis point arrays do not match in length
  #
  # ==== Examples
  # g = Rubyplot::Scatter.new
  # g.data(:apples, [1,2,3], [3,2,1])
  # g.data('oranges', [1,1,1], [2,3,4])
  # g.data('bitter_melon', [3,5,6], [6,7,8], '#000000')
  #
  def data(name, x_data_points = [], y_data_points = [], z_data_points = [], _color = nil)
    # Call the existing data routine for the y axis data
    data_y(name, y_data_points, z_data_points)
    # append the x data to the last entry that was just added in the @data member
    last_elem = @data.length - 1
    @data[last_elem] << x_data_points

    if @maximum_x_value.nil? && @minimum_x_value.nil?
      @maximum_x_value = @minimum_x_value = x_data_points.first
    end
    @z_data = z_data_points
    x_z_array_sum = [x_data_points, z_data_points].transpose.map { |x| x.reduce(:+) }
    x_z_array_diff = [x_data_points, z_data_points].transpose.map { |x| x.reduce(:-) }

    @maximum_x_value = x_z_array_sum.max > @maximum_x_value ?
                        x_z_array_sum.max : @maximum_x_value
    @minimum_x_value = x_z_array_sum.min < @minimum_x_value ?
                        x_z_array_sum.min : @minimum_x_value

    @maximum_x_value = x_z_array_diff.max > @maximum_x_value ?
                        x_z_array_diff.max : @maximum_x_value
    @minimum_x_value = x_z_array_diff.min < @minimum_x_value ?
                        x_z_array_diff.min : @minimum_x_value
  end
end
