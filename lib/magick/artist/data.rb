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
    def data(data_points = [], label: :default, color: :default)
      name = label == :default ? ' ' : label.to_s
      data_points = Array(data_points) # make sure it's an array
      # TODO: Adding an empty color array which can be developed later
      # to make graphs super customizable with regards to coloring of
      # individual data points.
      @data << [name, data_points, color]
      # Set column count if this is larger than previous column counts
      @geometry.column_count = data_points.length > @geometry.column_count ? data_points.length : @geometry.column_count

      # Pre-normalize => Set the max and min values of the data.
      data_points.each do |data_point|
        # Initialize the maximum and minimum values so that the spread starts
        # at the lowest points in the data and then changes as iteration.
        if @geometry.maximum_value.nil? && @geometry.minimum_value.nil?
          @geometry.maximum_value = @geometry.minimum_value = data_point
        end

        @geometry.maximum_value = data_point > @geometry.maximum_value ? data_point : @geometry.maximum_value
        @geometry.minimum_value = data_point < @geometry.minimum_value ? data_point : @geometry.minimum_value
        @geometry.has_data = true
      end
    end
  end
end
