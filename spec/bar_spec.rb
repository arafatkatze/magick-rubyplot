require 'spec_helper'
describe 'Bar' do
  it 'Make a Bar plot of a graph' do
    g = Rubyplot::Bar.new(600)
    g.title = 'Formatted numbers'
    g.marker_count = 8
    g.data('data', [5, 12, 1, 6, 7])
    g.write('bar.png')
  end
end
