require 'rubyplot'
def setup_stack_bar_data
  @datasets = [
    [:Charles, [20, 10, 5, 12, 11, 6, 10, 7], [5, 10, 19, 6, 9, 1, 14, 8]],
    [:Adam, [5, 10, 20, 6, 9, 12, 14, 8], [20, 10, 5, 12, 11, 6, 10, 7]],
    [:Daniel, [19, 9, 6, 11, 12, 7, 15, 8], [6, 11, 18, 8, 12, 8, 10, 6]]
  ]

  @datasets2 = [
    [:Car, [25, 36, 86, 39]],
    [:Bus, [80, 54, 67, 54]],
    [:Train, [22, 29, 35, 38]]
  ]
end

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
    plot.data(data[0], data[1])
  end

  plot.set_colors_array(%w[blue red yellow])
  plot.write('spec/reference_images/stacked_bar.png')
end
