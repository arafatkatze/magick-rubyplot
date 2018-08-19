module Rubyplot
  class Figure
    # Plots a scatterplot on the active subplotGR of the figure
    # @param x_coordinates [Array] A list of x coordinates of points to be plotted
    # @param y_coordinates [Array] A list of y coordinates of points to be plotted
    # @param marker_size [Float] The size of markers
    # @param marker_color [String or Symbol] Color of marker, can be a hex String
    #  (#rrbbgg) or symbol from Rubyplot::Color
    # @param marker_type [Symbol] A symbol for Marker type from
    #  Rubyplot::GRWrapper::Tasks::GR_MARKER_SHAPES
    def scatter!(x_coordinates, y_coordinates, marker_size: :default,
                 marker_color: :default, marker_type: :default, label: :default)
      if @backend == :default || @backend == :GR
        @active_subplotGR.x_range[0] = x_coordinates.min if @active_subplotGR.x_range[0].nil?
        @active_subplotGR.x_range[1] = x_coordinates.max if @active_subplotGR.x_range[1].nil?
        @active_subplotGR.x_range[0] = x_coordinates.min if x_coordinates.min < @active_subplotGR.x_range[0]
        @active_subplotGR.x_range[1] = x_coordinates.max if x_coordinates.max > @active_subplotGR.x_range[1]

        @active_subplotGR.y_range[0] = y_coordinates.min if @active_subplotGR.y_range[0].nil?
        @active_subplotGR.y_range[1] = y_coordinates.max if @active_subplotGR.y_range[1].nil?
        @active_subplotGR.y_range[0] = y_coordinates.min if y_coordinates.min < @active_subplotGR.y_range[0]
        @active_subplotGR.y_range[1] = y_coordinates.max if y_coordinates.max > @active_subplotGR.y_range[1]

        @active_subplotGR.tasks.push(Rubyplot::Scripting::Plots::Scatter.new(x_coordinates, y_coordinates,
                                                                             marker_size: marker_size, marker_color: marker_color,
                                                                             marker_type: marker_type))
      else
        @init += 1
        if @init == 1
          @plot = Rubyplot::Scatter.new(400)
          @plot.data x_coordinates, y_coordinates, color: marker_color, label: label
        else
          @plot.data x_coordinates, y_coordinates, color: marker_color, label: label
        end
      end
    end

    # Plots a bar graph
    # @param data [Float Array] Array containing values of bars
    # @param bar_color [String or Symbol] Color of bars, can be a hex String
    #  (#rrbbgg) or symbol from Rubyplot::Color
    # @param bar_width [Float] Width of bar
    # @param bar_gap [Float] Gap between consecutive bars
    # @param bar_edge [Boolean] Argument to draw edge for bar (True by default)
    # @param bar_edge_color [String or Symbol] Color of bar's edge, can be a hex
    #  string (#rrbbgg) or symbol from Rubyplot::Color
    # @param bar_edge_width [Float] Width of bar edge
    def bar!(data, bar_color: :default, bar_width: :default,
             bar_gap: :default, bar_edge: :default, bar_edge_color: :default,
             bar_edge_width: :default)

      @active_subplotGR.x_range[0] = 0 if @active_subplotGR.x_range[0].nil?
      @active_subplotGR.x_range[1] = data.length if @active_subplotGR.x_range[0].nil?
      bar_gap = 0 if bar_gap == :default
      bar_width = 1 if bar_width == :default
      bar_edge_width = 0.03 if bar_edge_width == :default
      x_length = data.length * (bar_width + bar_gap) + bar_width + bar_edge_width
      @active_subplotGR.x_range[1] = x_length if x_length > @active_subplotGR.x_range[1]

      @active_subplotGR.y_range[0] = data.min if @active_subplotGR.y_range[0].nil?
      @active_subplotGR.y_range[1] = data.max if @active_subplotGR.y_range[1].nil?
      @active_subplotGR.y_range[0] = data.min if data.min < @active_subplotGR.y_range[0]
      @active_subplotGR.y_range[1] = data.max if data.max > @active_subplotGR.y_range[1]
      @active_subplotGR.tasks.push(Rubyplot::Scripting::Plots::Bar.new(data, bar_color: bar_color, bar_width: bar_width,
                                                                             bar_gap: bar_gap, bar_edge: bar_edge,
                                                                             bar_edge_color: bar_edge_color,
                                                                             bar_edge_width: bar_edge_width))
    end

    # To view the Figure
    def view
      Rubyplot::Plotspace.new(self).view!
    end

    # To save the figure, currently only as .BMP files
    # known bug : save is not gvivng same output as view,in some cases
    #  this is an internal error in  GR Framework
    # @param file_name [String] name of the file where the figure needs to be saved
    def save(file_name)
      if @backend == :default || @backend == :GR
        Rubyplot::Plotspace.new(self).save!(file_name)
      else
        @plot.write(file_name)
      end
    end
  end
end
