require 'spec_helper'
describe 'Bar' do
  it 'Make a Bar plot of a graph' do
    base = Rubyplot::Bar.new(600)
    base.title = 'Random Bar numbers'
    base.marker_count = 8
    base.data('data', [5, 12, 9, 6, 7])
    base.write('spec/reference_images/bar.png')

    g = Rubyplot::Bar.new(600)
    g.title = 'Random Bar numbers'
    g.marker_count = 8
    g.data('data', [5, 12, 9, 6, 7])
    g.write('spec/reference_images/bar-test-1.png')
    expect(compare_with_reference?('bar.png', 'bar-test-1.png', 10)).to eq(true)
  end

  it 'Fails to match with the reference image' do
    g = Rubyplot::Bar.new(600)
    g.title = 'Random Bar numbers'
    g.marker_count = 8
    g.data('data', [5, 12, 9, 6, 6])
    g.write('spec/reference_images/bar-test-2.png')

    expect(compare_with_reference?('bar.png', 'bar-test-2.png', 10)).to eq(false)
  end
end
