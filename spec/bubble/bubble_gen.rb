require 'rubyplot'
# Makes a Bar graph with random graph numbers
def make_bubble
  base = Rubyplot::Bubble.new
  base.data([-1, 19, -4, -23], [-35, 21, 23, -4], [45, 10, 21, 9],label: :apples)
  base.data([20, 30, -6, -3], [-1, 5, -27, -3], [13, 10, 20, 10],label: :peaches)
  base.write('spec/reference_images/bubble_test_1.png')

  base.get_colors_array
end
