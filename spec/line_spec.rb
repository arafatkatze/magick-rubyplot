require 'spec_helper'
describe 'Graph' do
  it 'Make a line plot of a graph' do
    g = Rubyplot::Line.new
    g.title = 'A Line Graph'
    g.labels = {
      0 => 'Ola Ruby',
      1 => 'Hello ruby'
    }
    # Data inputted and normalized like the usual cases.
    g.data(:Marco, [20, 23, 19, 8])
    g.data(:John, [1, 53, 76, 18])
    # Starting the ultimate Write script of the whole thing.
    g.write('spec/reference_images/line-test-1.png')
    expect(compare_with_reference?('line.png', 'line-test-1.png', 10)).to eq(true)
  end

  it 'Fails to match with the reference image' do
    g = Rubyplot::Line.new
    g.title = 'A Line Graph'
    g.labels = {
      0 => 'Ola Ruby',
      1 => 'Hello ruby'
    }
    # Data inputted and normalized like the usual cases.
    g.data(:Marco, [20, 23, 19, 8])
    g.data(:John, [1, 53, 76, 19])
    # Starting the ultimate Write script of the whole thing.
    g.write('spec/reference_images/line-test-2.png')
    expect(compare_with_reference?('line.png', 'line-test-2.png', 10)).to eq(false)
  end
end
