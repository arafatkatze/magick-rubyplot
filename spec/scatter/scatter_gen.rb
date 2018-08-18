require 'rubyplot'
def random_scatter
  plot = Rubyplot::Scatter.new(400)
  plot.data( [1, 2, 3, 4, 5], [11, 2, 33, 4, 65], :data1, color:  :plum_purple)
  plot.write('spec/reference_images/scatter.png')
end

def setup_basic_scatter(size = 800)
  setup_data
  plot = Rubyplot::Scatter.new(size)
  plot.title = 'Rad Graph'
  @datasets.each do |data|
    plot.data( data[1], data[2],data[0])
  end
  plot
end

def setup_pos_neg(size = 800)
  plot = Rubyplot::Scatter.new(size)
  plot.title = 'Pos/Neg Scatter Graph Test'
  plot.data([-1, 0, 4, -4], [-5, -1, 3, 4],  :apples)
  plot.data( [10, 8, 6, 3], [-1, 1, 3, 3],   :peaches)
  plot
end

def setup_all_neg(size = 800)
  plot = Rubyplot::Scatter.new(size)
  plot.title = 'Neg Scatter Graph Test'
  plot.data([-1, -1, -4, -4], [-5, -1, -3, -4], :apples)
  plot.data([-10, -8, -6, -3], [-1, -1, -3, -3],:peaches)
  plot
end
