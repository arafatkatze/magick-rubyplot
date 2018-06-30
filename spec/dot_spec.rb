require 'spec_helper'
describe 'Graph' do
  it 'Make a dot plot of a graph' do
    random_dots
    g = Rubyplot::Dot.new
    g.labels = {
      0 => '5/6',
      1 => '5/15',
      2 => '5/24',
      3 => '5/30'
    }
    g.data(:Cars, [0, 5, 8, 15])
    g.data(:Bus, [10, 3, 2, 8])
    g.data(:Science, [2, 15, 8, 11])

    g.minimum_value = 0
    g.write('spec/reference_images/dot-test-1.png')
    expect(compare_with_reference?('dot.png', 'dot-test-1.png', 10)).to eq(true)
  end

  it 'Fails to match with the reference image' do
    g = Rubyplot::Dot.new
    g.labels = {
      0 => '5/6',
      1 => '5/15',
      2 => '5/24'
    }
    g.data(:Cars, [0, 5, 8, 15])
    g.data(:Bus, [10, 3, 2, 8])
    g.data(:Science, [2, 15, 8, 11])

    g.minimum_value = 0
    g.write('spec/reference_images/dot-test-2.png')
    expect(compare_with_reference?('dot.png', 'dot-test-2.png', 10)).to eq(false)
  end
end
