require 'rubyplot'

def random_lines
  plot = Rubyplot::Line.new
  plot.title = 'A Line Graph'
  plot.labels = {
    0 => 'Ola Ruby',
    1 => 'Hello ruby'
  }
  # Data inputted and normalized like the usual cases.
  plot.data(:Marco, [20, 23, 19, 8], 'blue')
  plot.data(:John, [1, 53, 76, 18], 'green')
  # Starting the Write script of the whole plot.
  plot.write('spec/reference_images/line.png')
  plot.get_colors_array
end
