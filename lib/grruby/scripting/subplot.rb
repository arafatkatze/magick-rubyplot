module Rubyplot
  # Contains the state of the subplotGR and also handles it plotting
  # The objects of this class is instantited by the Figure objects when
  # the user calls #subplotGR! on the Figure object.
  # @todo Delegate plotting to subplotGRspace
  class SubplotGR
    include Rubyplot::GRWrapper::Tasks
    include Rubyplot::Color
    attr_accessor :backend, :x_title, :y_title, :x_range, :y_range,
                  :x_tick_count, :y_tick_count, :title, :text_font, :grid,
                  :bounding_box, :x_axis_padding, :y_axis_padding, :origin,
                  :title_shift, :tasks
    attr_reader :identity

    # Constructor for subplotGR object
    # @param num_rows [Fixnum] Number of Rows for the subplotGR matrix
    # @param num_columns [Fixnum] Number of Rows for the subplotGR matrix
    # @param index [Fixnum] Index of the active subplotGR in matrix (Row major)
    def initialize(num_rows, num_columns, index)
      @identity = [num_rows, num_columns, index]
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
    end

    # clears the state of the subplotGR
    def clear!
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
    end

    # plots the subplotGR based on the state and tasklist
    def call
      r = (@identity[2].to_f / @identity[1].to_f).ceil
      c = (@identity[2] % @identity[1]).zero? ? @identity[1] : @identity[2] % @identity[1]
      @ymax = 1 - (1.to_f / @identity[0]) * (r - 1) - 0.095 / @identity[0]
      @ymin = 1 - (1.to_f / @identity[0]) * r + 0.095 / @identity[0]
      @xmin = (1.to_f / @identity[1]) * (c - 1) + 0.095 / @identity[1]
      @xmax = (1.to_f / @identity[1]) * c - 0.095 / @identity[1]

      @x_axis_padding = Math.log((@x_range[1] - @x_range[0]), 10).round
      @y_axis_padding = Math.log((@y_range[1] - @y_range[0]), 10).round

      @origin[0] = @x_range[0] - @x_axis_padding if @origin[0] == :default
      @origin[1] = @y_range[0] - @y_axis_padding if @origin[1] == :default

      SetViewPort.new(@xmin, @xmax, @ymin, @ymax).call
      SetWindow.new(@x_range[0] - @x_axis_padding, @x_range[1] + @x_axis_padding,
                    @y_range[0] - @y_axis_padding, @y_range[1] + @y_axis_padding).call
      # Make sure that window is set bigger than range figure out how to manage it
      SetTextAlign.new(2, 0).call
      @text_font = :times_roman if @text_font == :default
      SetTextFontPrecision.new(GR_FONTS[@text_font],
                               GR_FONT_PRECISION[:text_precision_string]).call
      SetCharHeight.new(0.012).call
      @y_tick_count = 10 if @y_tick_count == :default
      @x_tick_count = 10 if @x_tick_count == :default # 10 ticks by default
      SetLineColorIndex.new(hex_color_to_gr_color_index(COLOR_INDEX[:black])).call
      SetLineWidth.new(1).call
      SetLineType.new(GR_LINE_TYPES[:solid]).call
      Grid.new((@x_range[1] - @x_range[0]).to_f / @x_tick_count,
               (@y_range[1] - @y_range[0]).to_f / @y_tick_count,
               0, 0, 1, 1).call
      Axes.new((@x_range[1] - @x_range[0]).to_f / @x_tick_count,
               (@y_range[1] - @y_range[0]).to_f / @y_tick_count,
               @origin[0], @origin[1], 1, 1, 0.01).call
      AxesTitles.new(@x_title, @y_title, '').call
      @tasks.each do |task|
        task.call if task.plot_type == :robust
        task.call(self) if task.plot_type == :lazy
      end
    end
  end
end
