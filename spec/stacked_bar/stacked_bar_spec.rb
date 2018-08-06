require 'spec_helper'

describe :StackedBar do
  it 'Makes a stacked bar graph with predefined colors' do
    setup_stack_bar_data
    setup_stack_bar_test_image
    plot = Rubyplot::StackedBar.new
    plot.title = 'Net earnings in different months'
    plot.labels = {
      0 => 'Jan',
      1 => 'Feb',
      2 => 'March',
      3 => 'April',
      4 => 'May',
      5 => 'June',
      6 => 'July',
      7 => 'August',
      8 => 'September',
      9 => 'October',
      10 => 'November',
      11 => 'December'
    }

    @datasets.each do |data|
      plot.data(data[0], data[1])
    end
    plot.set_colors_array(%w[blue red yellow])
    plot.write('spec/reference_images/stacked_bar_test_1.png')
    expect(compare_with_reference?('stacked_bar.png', 'stacked_bar_test_1.png', 10)).to eq(true)
  end

  it 'Makes a stacked bar graph with small size' do
    setup_stack_bar_data
    plot = Rubyplot::StackedBar.new(400)
    plot.title = 'Stacked Bar'
    plot.labels = {
      0 => '5/6',
      1 => '5/15',
      2 => '5/24',
      3 => '5/30'
    }
    @datasets2.each do |data|
      plot.data(data[0], data[1])
    end
    plot.write('spec/reference_images/stacked_bar_test_2.png')
  end
end
