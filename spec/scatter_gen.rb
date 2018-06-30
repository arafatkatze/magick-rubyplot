require 'rubyplot'
def random_scatter
  g = Rubyplot::Scatter.new(400)
  g.data(:data1, [1, 2, 3, 4, 5], [11, 2, 33, 4, 65])
  g.write('spec/reference_images/scatter.png')
end
