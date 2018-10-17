module Rubyplot
  # Figure is the class that a user instantiates
  # this is where all the plotting take place.
  # An instance contains the state of the figure.
  #
  # Every plot in the figure is a subplotGR.
  # It is subplotGR(1,1,1) by default
  #
  # @author Pranav Garg
  class Figure
    include Rubyplot::Scripting::Plots
    include Rubyplot::GRWrapper::Tasks
    attr_accessor :backend, :x_title, :y_title, :x_range, :y_range,
                  :x_tick_count, :y_tick_count, :text_font, :grid,
                  :bounding_box, :x_axis_padding, :y_axis_padding, :origin,
                  :title_shift, :subplotGRs_list
    attr_reader :tasks

    # Constructor for the figure object
    # @param backend [Symbol] Loads the desired backend, :GR by default
    def initialize(backend: :default)
      @backend = backend
      if @backend == :default || @backend == :GR
        @subplotGRs_list = [Rubyplot::SubplotGR.new(1, 1, 1)]
        @tasks = []
        @x_title = ''
        @y_title = ''
        @x_range = [0, 0]
        @y_range = [0, 0]
        @origin = %i[default default]
        @x_tick_count = :default
        @y_tick_count = :default
        @title = nil
        @title_shift = 0
        @text_font = :default
        @grid = true
        @bounding_box = true
        @x_axis_padding = :default
        @y_axis_padding = :default
        if @backend == :default || @backend == :GR
          #  require(__dir__.to_s << '/scripting_backends/gr/gr_backend')
        end
        @active_subplotGR = @subplotGRs_list[0]
        @no_subplotGR = true
      else
        @init = 0
        @plot = []
      end
    end

    # Clears the figure by resetting the state to the state to default
    def clear_figure!
      @subplotGRs_list = [Rubyplot::SubplotGR.new(1, 1, 1)]
      @no_subplotGR = true
      @tasks = []
      @x_title = ''
      @y_title = ''
      @x_range = [0, 0]
      @y_range = [0, 0]
      @origin = [0, 0]
      @x_tick_count = :default
      @y_tick_count = :default
      @title = nil
      @title_shift = 0
      @text_font = :default
      @grid = true
      @bounding_box = true
      @x_axis_padding = :default
      @y_axis_padding = :default
      @active_subplotGR = @subplotGRs_list[0]
    end

    # clears the active subplotGR
    def clear!
      @active_subplotGR.clear!
    end

    # Creates a new subplotGR in the figure (if not defined before)
    # and loads it to to active_subplotGR and adds it to subplotGRs_list.
    # else loads existing subplotGR from subplotGRs_list to active_subplotGR
    # @param num_rows [Fixnum] Number of Rows for the subplotGR matrix
    # @param num_columns [Fixnum] Number of Rows for the subplotGR matrix
    # @param index [Fixnum] Index of the active subplotGR in matrix (Row major)
    def subplotGR!(num_rows, num_columns, index)
      if @no_subplotGR
        @no_subplotGR = false
        @subplotGRs_list = []
      end
      subplotGR_id = [num_rows, num_columns, index]
      subplotGRs_list_index = @subplotGRs_list.map(&:identity).index subplotGR_id
      if subplotGRs_list_index.nil? == false
        @active_subplotGR = @subplotGRs_list[subplotGRs_list_index]
      else
        @active_subplotGR = Rubyplot::SubplotGR.new(num_rows, num_columns, index)
        @subplotGRs_list.push(@active_subplotGR)
      end
    end

    # Adds title to the active subplotGR
    # @param title [String] The title to be given to the active subplotGR
    def title(title_string)
      @active_subplotGR.title = title_string
    end

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
          @plot = Rubyplot::Scatter.new(1000)
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
             bar_edge_width: :default, label: :default)

      if @backend == :default || @backend == :GR
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
      else
        @init += 1
        if @init == 1
          @plot = Rubyplot::Bar.new(1000)
          @plot.data data, color: bar_color, label: label
        else
          @plot.data data, color: bar_color, label: label
        end
      end
    end

    # Plots a regular bar graph  in Z axis
    # @param data [Float Array] Array of Arrays containing values of bars
    # @param bar_color [Array of Strings or Array of Symbols] Array containing
    #  color of bars corresponding to eash list in data, an element can be a hex
    #  string(#rrbbgg) or symbol from Rubyplot::Color
    # @param bar_width [Float] Width of bar
    # @param bar_gap [Float] Gap between consecutive bars
    # @param bar_edge [Boolean] Argument to draw edge for bar (True by default)
    # @param bar_edge_color [String or Symbol] Color of bar's edge, can be a hex
    #  string (#rrbbgg) or symbol from Rubyplot::Color
    # @param bar_edge_width [Float] Width of bar edge
    def stacked_bar!(data, bar_colors: :default, bar_width: :default,
                     bar_gap: :default, bar_edge: :default, bar_edge_color: :default,
                     bar_edge_width: :default)
      if @backend == :default || @backend == :GR
        # Return error if negative data
        @active_subplotGR.x_range[0] = 0 if @active_subplotGR.x_range[0].nil?
        @active_subplotGR.x_range[1] = data[0].length if @active_subplotGR.x_range[1].nil?
        bar_gap = 0 if bar_gap == :default
        bar_width = 1 if bar_width == :default
        bar_edge_width = 0.03 if bar_edge_width == :default
        x_length = data[0].length * (bar_width + bar_gap) + bar_width + bar_edge_width
        @active_subplotGR.x_range[1] = x_length if x_length > @active_subplotGR.x_range[1]
        summed_heights = data.transpose.map { |x| x.reduce(:+) }
        @active_subplotGR.y_range[0] = 0 if @active_subplotGR.y_range[0].nil?
        @active_subplotGR.y_range[1] = summed_heights.max if @active_subplotGR.y_range[1].nil?
        @active_subplotGR.y_range[1] = summed_heights.max if summed_heights.max > @active_subplotGR.y_range[1]
        @active_subplotGR.tasks.push(Rubyplot::Scripting::Plots::StackedBar.new(data, bar_colors: bar_colors, bar_width: bar_width,
                                                                                      bar_gap: bar_gap, bar_edge: bar_edge,
                                                                                      bar_edge_color: bar_edge_color,
                                                                                      bar_edge_width: bar_edge_width))
      else
        @init += 1
        if @init == 1
          @plot = Rubyplot::StackedBar.new(1000)
          @plot.data data
        else
          @plot.data data
        end
      end
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
