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
    plot.data(:apples, [-1, 19, -4, -23], [-35, 21, 23, -4], [45, 10, 21, 9])
    plot.data(:peaches, [20, 30, -6, -3], [-1, 5, -27, -3], [13, 10, 20, 10])
    plot.set_colors_array(colors)
    plot.write('spec/reference_images/bubble_test_2.png')

    expect(compare_with_reference?('bubble_test_1.png', 'bubble_test_2.png', 10)).to eq(true)
  end
end
