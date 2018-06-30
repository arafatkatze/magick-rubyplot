require 'rubyplot'

def random_dots
  g = Rubyplot::Dot.new
  g.labels = {
    0 => '5/6',
    1 => '5/15',
    2 => '5/24',
    3 => '5/30'
  }
  g.data(:Cars, [0, 5, 8, 15])
  g.data(:Bus, [10, 3, 2, 8])
  g.data(:Science, [2, 15, 8, 11])
  g.minimum_value = 0

  g.write('spec/reference_images/dot.png')
end
