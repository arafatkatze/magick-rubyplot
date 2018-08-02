require 'spec_helper'

describe :SubPlot do
  it 'Makes a stacked bar graph with predefined colors' do
    plot = Rubyplot::SubPlot.new(2, 3)
  end
end
