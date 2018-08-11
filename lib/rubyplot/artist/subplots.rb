module Rubyplot
  class SubPlot
    # Makes a grid of M x N dimensions.
    # M -> Num of vertical images.
    # N -> Num of horizontal images.
    def initialize(m, n)
      @m = m
      @n = n
      @grid_array = Array.new((m * n), nil)
    end

    # Adds a plot at a given index in the subplot.
    def addplot(plot, index)
      index -= 1
      if @grid_array[index].nil?
        plot.draw
        @grid_array[index] = plot.base_image
      end
    end

    # Adds a image at a given index in the subplot.
    # NOTE: The image here is any standard image read by RMagick read function
    def addimage(index, image)
      index -= 1
      @grid_array[index] = image if @grid_array[index].nil?
    end

    def max(a, b)
      a > b ? a : b
    end

    # Writes subplot to a file.
    def write(filename)
      @max_x_pixels = 0
      @max_y_pixels = 0
      # Calculating the maximum value of the x pixels in the subplot.
      for i in 0..(@m - 1)
        x_pixel_sum = 10
        for j in 0..(@n - 1)
          index = i * @n + j
          x_pixel_sum += @grid_array[index].columns unless @grid_array[index].nil?
          x_pixel_sum += 10
        end
        @max_x_pixels = max(@max_x_pixels, x_pixel_sum)
      end

      # Calculating the maximum value of the y pixels in the subplot.
      for j in 0..(@n - 1)
        y_pixel_sum = 10
        for i in 0..(@m - 1)
          index = i * @n + j
          y_pixel_sum += @grid_array[index].rows unless @grid_array[index].nil?
          y_pixel_sum += 10
        end
        @max_y_pixels = max(@max_y_pixels, y_pixel_sum)
      end

      # Making the empty base image(white background) on which the plots are overlayed
      base_image = Magick::Image.new(@max_x_pixels, @max_y_pixels) { self.background_color = 'white' }

      y_pixel = 10
      for i in 0..(@m - 1)
        x_pixel_sum = 10
        y_pixel_max = 0
        for j in 0..(@n - 1)
          index = i * @n + j
          next if @grid_array[index].nil?
          # Using Composite function to overlay the plots on the base image
          base_image = base_image.composite(@grid_array[index], Magick::ForgetGravity, x_pixel_sum, y_pixel, Magick::OverCompositeOp)
          x_pixel_sum += @grid_array[index].columns
          x_pixel_sum += 10
          y_pixel_max = max(y_pixel_max, @grid_array[index].rows)
        end
        y_pixel += y_pixel_max + 10
      end
      # Writing the subplot to to a file.
      base_image.write(filename)
    end
  end
end
