require 'rubyplot'

g = Rubyplot::Figure.new(backend: :magick)
@x1 = [1, 2, 3, 4, 5]
@y1 = [10, 29, 30, 40, 50]
@x2 = [4, 11, 25]
@y2 = [32, 47, 60]
g.text_font = :bookman_light_italic
g.scatter! @x1, @y1, marker_color: :green, label: :cars
g.scatter! @x2, @y2, marker_color: :red, label: :trains
g.save('scatter.png')

g2 = Rubyplot::Figure.new(backend: :GR)
g2.text_font = :bookman_light_italic
g2.scatter! @x1, @y1, marker_color: :green

g2.scatter! @x2, @y2, marker_color: :red
g2.save('scatter.bmp')
g2.view
