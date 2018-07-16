describe 'Bubble' do
  before do
    @bubble_data = [[12, 4, 53, 24],
                    [4, 34, 8, 25],
                    [20, 9, 31, 2],
                    [56, 12, 84, 30]]
  end

  it 'Creates a Bubble graph' do
    colors = make_bubble
    plot = Rubyplot::Bubble.new
    plot.data(:apples, [-1, -1, -4, -4], [-5, -1, -3, -4], [5, 10, 11, 9])
    plot.data(:peaches, [-10, -8, -6, -3], [-1, -5, -7, -3], [13, 17, 10, 10])
    plot.set_colors_array(colors)
    plot.write('spec/reference_images/bubble_test_1.png')

    expect(compare_with_reference?('bubble.png', 'bubble_test_1.png', 10)).to eq(true)
  end
end
