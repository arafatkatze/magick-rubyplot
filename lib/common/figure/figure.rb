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
    def initialize
      @backend = Rubyplot.backend
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
  end
end
