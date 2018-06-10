module Rubyplot
  class Artist
    include Magick
    # Parameters are an array where the first element is the name of the dataset
    # and the value is an array of values to plot.
    #
    # Can be called multiple times with different datasets for a multi-valued
    # graph.
    #
    # Example:
    #   data("Arafat", [95, 45, 78, 89, 88, 76])
    def data(name, data_points = [])
      data_points = Array(data_points) # make sure it's an array
      # TODO: Adding an empty color array which can be developed later
      # to make graphs super customizable with regards to coloring of
      # individual data points.
      color = []
      @data << [name, data_points, color]
      # Set column count if this is larger than previous column counts
      @column_count = data_points.length > @column_count ? data_points.length : @column_count

      # Pre-normalize => Set the max and min values of the data.
      data_points.each do |data_point|
        # Initialize the maximum and minimum values so that the spread starts
        # at the lowest points in the data and then changes as iteration.
        if @maximum_value.nil? && @minimum_value.nil?
          @maximum_value = @minimum_value = data_point
        end

        @maximum_value = data_point > @maximum_value ? data_point : @maximum_value
        @minimum_value = data_point < @minimum_value ? data_point : @minimum_value
        @has_data = true
      end
    end
  end
end
