$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

# Include Paths
require 'rubyplot'
require 'data_array'
require 'bar/bar_gen'
require 'dot/dot_gen'
require 'line/line_gen'
require 'scatter/scatter_gen'
require 'bubble/bubble_gen'
require 'stacked_bar/stacked_gen'

class RubyplotSpec
  def self.describe(*args, &block)
    %i[GR magick].each do |backend|
      Rubyplot.backend = backend
      ::RSpec.describe args, &block
    end
  end
end

RSpec::Matchers.define :eq_image do |expected_image, delta|
  match do |actual_image|
    compare_with_reference? actual_image, expected_image, delta
  end
end

def compare_with_reference?(test_image, reference_image, tolerance)
  compute_rms(test_image, reference_image) < tolerance
end

# Computes the RMS value between two images
def compute_rms(test_image, reference_image)
  image1 = Magick::Image.read(('spec/reference_images/' + test_image)).first
  image2 = Magick::Image.read(('spec/reference_images/' + reference_image)).first
  diff = 0
  pixel_array_1 = image1.export_pixels
  pixel_array_2 = image2.export_pixels
  for i in 0..(pixel_array_1.size - 1)
    diff += ((pixel_array_1[i] - pixel_array_2[i]).abs / 3)**2
  end
  Math.sqrt(diff / (512 * 512))
end
