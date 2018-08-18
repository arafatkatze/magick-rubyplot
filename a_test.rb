require 'rubyplot'

g = Rubyplot::Figure.new(backend: :magick)
@x1 = [1, 2, 3, 4, 5]
@y1 = [10, 29, 30, 40, 50]
g.text_font = :bookman_light_italic
g.scatter! @x1, @y1, marker_color: :green
g.save('scatter.png')
# g.view
