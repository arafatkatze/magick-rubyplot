##
#  This class perfoms the y coordinats conversion for the bar class.
#
#  There are three cases:
#
#   1. Bars all go from zero in +ve direction
#   2. Bars all go from zero to -ve direction
#   3. Bars can either go from zero to +ve or from zero to -ve
#
class Rubyplot::Bar
  attr_writer :mode
  attr_writer :zero
  attr_writer :graph_top
  attr_writer :graph_height
  attr_writer :minimum_value
  attr_writer :spread

  def get_left_y_right_y_scaled(data_point, result)
    case @mode
    when :positive then # Case one
      # minimum value >= 0 ( only positiv values ) -> all the bars go in the +ve direction
      result[0] = @graph_top + @graph_height * (1 - data_point) + 1
      result[1] = @graph_top + @graph_height - 1
    when :negative then # Case two
      # only negative values -> all the bars go in the -ve direction
      result[0] = @graph_top + 1
      result[1] = @graph_top + @graph_height * (1 - data_point) - 1
    when :both then # Case three
      # positive and negative values -> bars go in both the +ve and -ve direction
      val = data_point - @geometry.minimum_value / @spread
      if data_point >= @zero
        result[0] = @graph_top + @graph_height * (1 - (val - @zero)) + 1
        result[1] = @graph_top + @graph_height * (1 - @zero) - 1
      else
        result[0] = @graph_top + @graph_height * (1 - (val - @zero)) + 1
        result[1] = @graph_top + @graph_height * (1 - @zero) - 1
      end
    else
      result[0] = 0.0
      result[1] = 0.0
    end
  end
end
