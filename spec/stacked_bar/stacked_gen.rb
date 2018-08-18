require 'rubyplot'

def setup_stack_bar_test_image
  setup_stack_bar_data
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
    plot.data(data[1],label: data[0])
  end

  plot.write('spec/reference_images/stacked_bar.png')
end
