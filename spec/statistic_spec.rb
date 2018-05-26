require 'spec_helper'
describe 'Statistics Functions' do
  it 'Find mean of an array' do
    array_1 = Array.new([2, 4, 6, 8])
    expect(array_1.mean).to eq(5)
  end

  it 'Find median of an array' do
    array_1 = Array.new([2, 4, 6, 8, 10])
    expect(array_1.median).to eq(6)
  end

  it 'Find mode of an array' do
    array_1 = Array.new([2, 4, 6, 8, 10, 2])
    expect(array_1.modes).to eq([2])
  end
end
