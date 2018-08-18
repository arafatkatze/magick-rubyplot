require 'rubyplot'
def random_dots
  plot = Rubyplot::Dot.new
  plot.labels = {
    0 => '5/6',
    1 => '5/15',
    2 => '5/24',
    3 => '5/30'
  }
  plot.data( [0, 5, 8, 15],label: :Cars, color:  :maroon)
  plot.data( [10, 3, 2, 8],label: :Bus, color:  :grey)
  plot.data( [2, 15, 8, 11],label:  :Science, color:  :yellow)
  plot.minimum_value = 0

  plot.write('spec/reference_images/dot.png')
  plot.get_colors_array
end

def setup_basic_dot_graph(size = 800)
  setup_data
  plot = Rubyplot::Dot.new(size)
  plot.title = 'My Dot Graph'
  plot.labels = {
    0 => '5/6'
  }
  @datasets.each do |data|
    plot.data( data[1],label: data[0])
  end
  plot
end
