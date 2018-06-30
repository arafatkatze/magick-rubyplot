require 'rubyplot'

def random_bars
  base = Rubyplot::Bar.new(600)
  base.title = 'Random Bar numbers'
  base.marker_count = 8
  base.data('data', [5, 12, 9, 6, 7])
  base.write('spec/reference_images/bar.png')
end
