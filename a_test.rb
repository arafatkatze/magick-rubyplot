require 'rubyplot'

values = [0, 24, 12, 48]
a = Rubyplot::Figure.new
a.bar! values
a.view

b = Rubyplot::Figure.new(backend: :magick)

b.bar! values, bar_color: :blue, label: 'car'
b.save('bar.png')
