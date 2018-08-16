class Rubyplot::Scatter < Rubyplot::Artist
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
  def data(name, x_data_points = [], y_data_points = [], color = nil)
    # Call the existing data routine for the y axis data
    super(name, y_data_points, color)

    # append the x data to the last entry that was just added in the @data member
    last_elem = @data.length - 1
    @data[last_elem] << x_data_points

    if @geometry.maximum_x_value.nil? && @geometry.minimum_x_value.nil?
      @geometry.maximum_x_value = @geometry.minimum_x_value = x_data_points.first
    end

    @geometry.maximum_x_value = x_data_points.max > @geometry.maximum_x_value ?
                        x_data_points.max : @geometry.maximum_x_value
    @geometry.minimum_x_value = x_data_points.min < @geometry.minimum_x_value ?
                        x_data_points.min : @geometry.minimum_x_value
  end

  def calculate_spread #:nodoc:
    super
    @x_spread = @geometry.maximum_x_value.to_f - @geometry.minimum_x_value.to_f
    @x_spread = @x_spread > 0 ? @x_spread : 1
  end

  def normalize(force = nil)
    if @geometry.norm_data.nil? || force
      @geometry.norm_data = []
      return unless @geometry.has_data

      @data.each do |data_row|
        norm_data_points = [data_row[DATA_LABEL_INDEX]]
        norm_data_points << data_row[DATA_VALUES_INDEX].map do |r|
          (r.to_f - @geometry.minimum_value.to_f) / @spread
        end

        norm_data_points << data_row[DATA_COLOR_INDEX]
        norm_data_points << data_row[DATA_VALUES_X_INDEX].map do |r|
          (r.to_f - @geometry.minimum_x_value.to_f) / @x_spread
        end
        @geometry.norm_data << norm_data_points
      end
    end
    # ~ @norm_y_baseline = (@geometry.baseline_y_value.to_f / @geometry.maximum_value.to_f) if @geometry.baseline_y_value
    # ~ @norm_x_baseline = (@geometry.baseline_x_value.to_f / @geometry.maximum_x_value.to_f) if @geometry.baseline_x_value
  end
end
