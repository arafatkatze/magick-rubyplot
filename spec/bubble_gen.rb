require 'rubyplot'
# Makes a Bar graph with random graph numbers
def make_bubble
  base = Rubyplot::Bubble.new
  base.data(:apples, [-1, -1, -4, -4], [-5, -1, -3, -4], [5, 10, 11, 9])
  base.data(:peaches, [-10, -8, -6, -3], [-1, -5, -7, -3], [13, 17, 10, 10])
  base.write('spec/reference_images/bubble.png')

  base.get_colors_array
end
