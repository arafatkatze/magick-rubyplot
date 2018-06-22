$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'rubyplot'
require 'pry'
require 'phashion'
def compare_with_reference?(test_image, reference_image)
  img1 = Phashion::Image.new(('spec/reference_images/' + test_image))
  img2 = Phashion::Image.new(('spec/reference_images/' + reference_image))
  img1.distance_from(img2) < 2
end
