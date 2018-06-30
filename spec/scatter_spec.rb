require 'spec_helper'
describe 'Scatter' do
  it 'Make a scatter plot of a graph' do
    g = Rubyplot::Scatter.new(400)
    g.data(:data1, [1, 2, 3, 4, 5], [11, 2, 33, 4, 65])
    g.write('spec/reference_images/scatter.png')

    g = Rubyplot::Scatter.new(400)
    g.data(:data1, [1, 2, 3, 4, 5], [11, 2, 33, 4, 65])
    g.write('spec/reference_images/scatter-test-1.png')
    expect(compare_with_reference?('scatter.png', 'scatter-test-1.png', 10)).to eq(true)
  end

  it 'Fails to match with the reference image' do
    g = Rubyplot::Scatter.new(400)
    g.data(:data1, [1, 2, 3, 4, 5], [11, 2, 33, 4, 66])
    g.write('spec/reference_images/scatter-test-2.png')
    expect(compare_with_reference?('scatter.png', 'scatter-test-2.png', 10)).to eq(false)
  end
end
