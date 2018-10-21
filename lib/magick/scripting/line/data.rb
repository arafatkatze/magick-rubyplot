# This file contains the functions that help set up the user data
# to make it easily plottable.
module Rubyplot
  class Line < Artist
    # This method allows one to plot a dataset with both X and Y data.
    #
    # Parameters:
    #   name: string, the title of the datasets.
    #   x_data_points: an array containing the x data points for the graph.
    #   y_data_points: an array containing the y data points for the graph.
    #
    #   or
    #
    #   name: string, the title of the dataset.
    #   xy_data_points: an array containing both x and y data points for the graph.
    #
    #
    #  Notes:
    #   -if (x_data_points.length != y_data_points.length) an error is
    #     returned.
    #   -if you want to use a preset theme, you must set it before calling
    #     dataxy().
    #
    # Example:
    #   g = Rubyplot::Line.new
    #   g.title = "X/Y Dataset"
    #   g.dataxy("Apples", [1,3,4,5,6,10], [1, 2, 3, 4, 4, 3])
    #   g.dataxy("Bapples", [1,3,4,5,7,9], [1, 1, 2, 2, 3, 3])
    #   g.dataxy("Capples", [[1,1],[2,3],[3,4],[4,5],[5,7],[6,9]])
    #   #you can still use the old data method too if you want:
    #   g.data("Capples", [1, 1, 2, 2, 3, 3])
    #   #labels will be drawn at the x locations of the keys passed in.
    #   In this example the lables are drawn at x positions 2, 4, and 6:
    #   g.labels = {0 => '2003', 2 => '2004', 4 => '2005', 6 => '2006'}
    #   The 0 => '2003' label will be ignored since it is outside the chart range.
    def dataxy(_name, x_data_points = [], y_data_points = [], _color = nil)
      raise ArgumentError, 'x_data_points is nil!' if x_data_points.empty?

      if x_data_points.all? { |p| p.is_a?(Array) && p.size == 2 }
        y_data_points = x_data_points.map { |p| p[1] }
        x_data_points = x_data_points.map { |p| p[0] }
      end

      raise ArgumentError, 'x_data_points.length != y_data_points.length!' if x_data_points.length != y_data_points.length

      # call the existing data routine for the y data.
      data(y_data_points, label: :name)

      x_data_points = Array(x_data_points) # make sure it's an array
      # append the x data to the last entry that was just added in the @data member
      @data.last[DATA_VALUES_X_INDEX] = x_data_points

      # Update the global min/max values for the x data
      x_data_points.each do |x_data_point|
        next if x_data_point.nil?

        # Setup max/min so spread starts at the low end of the data points
        if @geometry.maximum_x_value.nil? && @geometry.minimum_x_value.nil?
          @geometry.maximum_x_value = @geometry.minimum_x_value = x_data_point
        end

        @geometry.maximum_x_value = x_data_point > @geometry.maximum_x_value ?
            x_data_point : @geometry.maximum_x_value
        @geometry.minimum_x_value = x_data_point < @geometry.minimum_x_value ?
            x_data_point : @geometry.minimum_x_value
      end
    end

    def normalize
      # First call the standard math function to normalize the values based on spread.
      super
      # TODO: Take care of the reference_lines

      # normalize the x data if it is specified
      @data.each_with_index do |data_row, index|
        norm_x_data_points = []
        next if data_row[DATA_VALUES_X_INDEX].nil?
        data_row[DATA_VALUES_X_INDEX].each do |x_data_point|
          norm_x_data_points << ((x_data_point.to_f - @geometry.minimum_x_value.to_f) / (@geometry.maximum_x_value.to_f - @geometry.minimum_x_value.to_f))
        end
        @geometry.norm_data[index] << norm_x_data_points
      end
    end

    def sort_norm_data
      super unless @data.any? { |d| d[DATA_VALUES_X_INDEX] }
    end

    def contains_one_point_only?(data_row)
      # A helper function that acts as a sanity check for the data.
      # It spins through data to determine if there is just one_value present.
      one_point = false
      data_row[DATA_VALUES_INDEX].each do |data_point|
        next if data_point.nil?
        if one_point
          # more than one point, bail
          return false
        end
        # there is at least one data point
        one_point = true
      end
      one_point
    end
  end
end
