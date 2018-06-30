require 'rubyplot'

def random_lines
  g = Rubyplot::Line.new
  g.title = 'A Line Graph'
  g.labels = {
    0 => 'Ola Ruby',
    1 => 'Hello ruby'
  }
  # Data inputted and normalized like the usual cases.
  g.data(:Marco, [20, 23, 19, 8])
  g.data(:John, [1, 53, 76, 18])
  # Starting the ultimate Write script of the whole thing.
  g.write('spec/reference_images/line.png')
end
