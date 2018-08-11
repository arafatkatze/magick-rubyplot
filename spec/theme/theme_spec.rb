require 'spec_helper'
# Test showing different available themes in the library.
describe :Themes do
  it 'Makes two subplots with different configurations' do
    plot = Rubyplot::Line.new
    plot.title = 'A Line Graph'
    plot.labels = {
      0 => 'Ola Ruby',
      1 => 'Hello ruby'
    }
    # Data inputted and normalized like the usual cases.
    plot.data(:Marco, [20, 23, 19, 8])
    plot.data(:John, [1, 53, 76, 18])
    # Starting the ultimate Write script of the whole thinplot.
    plot.set_colors_array(%w[orange blue])
    plot.write('spec/reference_images/theme_test.png')
    plot.theme = Rubyplot::Themes::CLASSIC_WHITE
    plot.write('spec/reference_images/theme2_test.png')
    plot.theme = Rubyplot::Themes::BASIC
    plot.write('spec/reference_images/theme3_test.png')
    plot.theme = Rubyplot::Themes::OREO
    plot.write('spec/reference_images/theme4_test.png')
    plot.theme = Rubyplot::Themes::TRACKS
    plot.write('spec/reference_images/theme5_test.png')
  end
end
