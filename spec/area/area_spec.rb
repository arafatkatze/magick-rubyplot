require 'spec_helper'

describe 'Area' do
  it 'test_area_graph' do
    @datasets = [
      [:Jimmy, [25, 36, 86, 39, 25, 31, 79, 88]],
      [:Charles, [80, 54, 67, 54, 68, 70, 90, 95]],
      [:Julie, [22, 29, 35, 38, 36, 40, 46, 57]],
      [:Jane, [3, 95, 95, 90, 85, 80, 88, 100]]
    ]
    g = Rubyplot::Area.new
    g.title = 'Visual Multi-Area Graph Test'
    g.labels = {
      0 => '0',
      2 => '2',
      4 => '4',
      6 => '6'
    }
    @datasets.each do |data|
      g.data( data[1],label: data[0])
    end
    # Default theme
    g.theme = Rubyplot::Themes::CLASSIC_WHITE
    g.write('spec/reference_images/area_test.png')
  end
end
