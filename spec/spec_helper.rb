$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'rubyplot'
require 'bar_gen'
require 'dot_gen'
require 'line_gen'
require 'scatter_gen'

def compare_with_reference?(test_image, reference_image, tolerance)
  compute_rms(test_image, reference_image) < tolerance
end

# Computes the RMS value between two images
def compute_rms(test_image, reference_image)
  image1 = Magick::Image.read(('spec/reference_images/' + test_image)).first
  image2 = Magick::Image.read(('spec/reference_images/' + reference_image)).first
  diff = 0
  (0..image1.columns).each do |x|
    (0..image1.rows).each do |y|
      pixel1 = image1.pixel_color(x, y)
      pixel2 = image2.pixel_color(x, y)
      diff += (((pixel1.red - pixel2.red).abs + (pixel1.blue - pixel2.blue).abs + (pixel1.green - pixel2.green).abs) / 3)**2
    end
  end
  Math.sqrt(diff / (512 * 512))
end
