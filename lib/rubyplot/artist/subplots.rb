module Rubyplot
  class SubPlot
    # Makes a grid of M x N dimensions
    def initialize(m, n)
      @m = m
      @n = n
      @grid_array = Array.new((m * n), nil)
    end

    # adds a plot at a given index
    def addplot(index, plot)
      @grid_array[index] = plot
    end
  end
end
