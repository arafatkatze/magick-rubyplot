require 'spec_helper'

describe :SubPlot do
  it 'Makes two subplots with different configurations' do
    plot1 = Rubyplot::Line.new
    plot1.title = 'A Line Graph'
    plot1.labels = {
      0 => 'Ola Ruby',
      1 => 'Hello ruby'
    }
    # Data inputted and normalized like the usual cases.
    plot1.data(:Marco, [20, 23, 19, 8])
    plot1.data(:John, [1, 53, 76, 18])
    # Starting the ultimate Write script of the whole thinplot.
    plot1.set_colors_array(%w[orange blue])

    plot2 = Rubyplot::Bar.new(600)
    plot2.title = 'Random Bar Numbers'
    plot2.marker_count = 8
    plot2.data('data', [5, 12, 9, 6, 7])

    plot3 = Rubyplot::Dot.new
    plot3.labels = {
      0 => '5/6',
      1 => '5/15',
      2 => '5/24'
    }
    plot3.data(:Cars, [0, 5, 8, 15])
    plot3.data(:Bus, [10, 3, 2, 8])
    plot3.data(:Science, [2, 15, 8, 11])
    plot3.minimum_value = 0

    setup_stack_bar_data
    plot4 = Rubyplot::StackedBar.new(400)
    plot4.title = 'Stacked Bar'
    plot4.labels = {
      0 => '5/6',
      1 => '5/15',
      2 => '5/24',
      3 => '5/30'
    }
    @datasets2.each do |data|
      plot4.data(data[0], data[1])
    end

    SubPlot1 = Rubyplot::SubPlot.new(1, 2)
    SubPlot1.addplot(plot1, 1)
    SubPlot1.addplot(plot2, 2)
    SubPlot1.write('spec/reference_images/subplot1_test.png')

    SubPlot2 = Rubyplot::SubPlot.new(3, 1)
    SubPlot2.addplot(plot1, 1)
    SubPlot2.addplot(plot2, 2)
    SubPlot2.addplot(plot3, 3)
    SubPlot2.write('spec/reference_images/subplot2_test.png')

    SubPlot3 = Rubyplot::SubPlot.new(2, 2)
    SubPlot3.addplot(plot1, 1)
    SubPlot3.addplot(plot2, 2)
    SubPlot3.addplot(plot3, 3)
    SubPlot3.addplot(plot4, 4)
    SubPlot3.write('spec/reference_images/subplot3_test.png')
  end
end
