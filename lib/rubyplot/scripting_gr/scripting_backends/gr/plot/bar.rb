module Rubyplot
  module Scripting
    module Plots
      class Bar < BasePlots::LazyBase
        def initialize(data, bar_color: :default, bar_width: :default,
                       bar_gap: :default, bar_edge: :default,
                       bar_edge_color: :default, bar_edge_width: :default)
          super()
          @bar_color = bar_color
          @bar_gap = bar_gap
          @bar_width = bar_width
          @bar_edge = bar_edge
          @bar_edge_color = bar_edge_color
          @bar_edge_width = bar_edge_width

          @bar_color = COLOR_INDEX[:blue] if @bar_color == :default
          @bar_color = COLOR_INDEX[bar_color] if @bar_color.is_a? Symbol
          @bar_gap = 0 if @bar_gap == :default
          @bar_width = 1 if @bar_width == :default
          @bar_edge_width = 0.053 if @bar_edge_width == :default
          @bar_edge = true if @bar_edge == :default
          @bar_edge_color = COLOR_INDEX[:black] if @bar_edge_color == :default
          @bar_edge_color = COLOR_INDEX[bar_edge_color] if @bar_edge_color.is_a? Symbol
          @data = data
          # All this will be repurposed
        end

        def call(state)
          # for Lazy plots the state has been passed  in the plotspace call
          # every lazy plot will have a call function rather than inherting it
          # tasks wont be pushed, rather they will be instantiated and called directly
          (0..@data.size - 1).to_a.each do |i|
            if @bar_edge
              SetFillColorIndex.new(hex_color_to_gr_color_index(@bar_edge_color)).call
              SetFillInteriorStyle.new(GR_FILL_INTERIOR_STYLES[:solid]).call
              FillRectangle.new(i * (@bar_width + @bar_gap) - @bar_edge_width,
                                i * (@bar_width + @bar_gap) + @bar_width + @bar_edge_width,
                                state.origin[1], @data[i] + 2 * @bar_edge_width).call
            end

            SetFillColorIndex.new(hex_color_to_gr_color_index(@bar_color)).call
            SetFillInteriorStyle.new(GR_FILL_INTERIOR_STYLES[:solid]).call
            FillRectangle.new(i * (@bar_width + @bar_gap),
                              i * (@bar_width + @bar_gap) + @bar_width,
                              state.origin[1], @data[i]).call
          end
        end
      end
    end
  end
end
