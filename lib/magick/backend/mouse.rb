require 'gtk3'

class Pics
  attr_accessor :pile, :picindex, :atBat, :image, :box, :window

  def initialize
    @window = Gtk::Window.new
    @window.signal_connect('destroy') { Gtk.main_quit }
    pic1 = 'a.png'
    pic2 = 'b.png'
    pic3 = 'c.png'
    @pile = [pic1, pic2, pic3]
    @picindex = 0
    get_image
    @box = Gtk::EventBox.new.add(@image)
  end

  def batter_up
    @box.remove(@image)
    @picindex += 1
    @picindex = 0 if @picindex == @pile.length
    get_image
    @box.add(@image)
    @box.show
  end

  def get_image
    @atBat = @pile[@picindex]
    img = GdkPixbuf::Pixbuf.new(@atBat, 200, 200)
    @image = Gtk::Image.new(pixbuf: img)
    @image.show
  end
end # class Pics

pics = Pics.new
pics.box.signal_connect('button_press_event') { pics.batter_up }
pics.window.set_default_size(200, 250)
pics.window.add(pics.box)
pics.window.show_all

Gtk.main
