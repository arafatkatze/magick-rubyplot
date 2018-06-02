# This module offers different rendering option for data points
# to be used with line graph. For now we have circle and square as choices.
module DotRenderers
  class Circle
    def render(d, new_x, new_y, circle_radius)
      d.circle(new_x, new_y, new_x - circle_radius, new_y)
    end
  end

  class Square
    def render(d, new_x, new_y, circle_radius)
      offset = (circle_radius * 0.8).to_i
      corner_1 = new_x - offset
      corner_2 = new_y - offset
      corner_3 = new_x + offset
      corner_4 = new_y + offset
      d.rectangle(corner_1, corner_2, corner_3, corner_4)
    end
  end

  def self.renderer(style)
    if style.to_s == 'square'
      Square.new
    else
      Circle.new
    end
  end
end
