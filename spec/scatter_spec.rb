require 'spec_helper'
describe 'Scatter' do
  it 'Make a scatter plot of a graph' do
    g = Rubyplot::Scatter.new(400)
    g.data(:data1, [1, 2, 3, 4, 5], [11, 2, 33, 4, 65])
    g.write('scatter.png')
  end
end
