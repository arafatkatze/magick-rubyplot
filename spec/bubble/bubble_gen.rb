require 'rubyplot'
# Makes a Bar graph with random graph numbers
def make_bubble
  base = Rubyplot::Bubble.new
  base.data(:apples, [-1, 19, -4, -23], [-35, 21, 23, -4], [45, 10, 21, 9])
  base.data(:peaches, [20, 30, -6, -3], [-1, 5, -27, -3], [13, 10, 20, 10])
  base.write('spec/reference_images/bubble_test_1.png')

  base.get_colors_array
end
