require 'RMagick'
require 'gtk3'

class RubyApp < Gtk::Window
  def initialize
    super

    init_ui
  end

  def init_ui
    override_background_color :normal, Gdk::RGBA.new(0.2, 0.2, 0.2, 1)
    begin
      bardejov = GdkPixbuf::Pixbuf.new file: 'log.png'
      sfsdf = GdkPixbuf::Pixbuf.new file: 'logo.png'
    rescue IOError => e
      puts e
      puts 'cannot load images'
      exit
    end

    image1 = Gtk::Image.new pixbuf: bardejov
    fixed = Gtk::Fixed.new
    add fixed
    fixed.put image1, 20, 20

    button = Gtk::Button.new label: 'Quit'
    button.set_size_request 80, 35
    button.signal_connect 'clicked' do
      puts 'hello world'

      img = Magick::Image.read('log.png').first
      img.resize_to_fit!(400, 400)
      img.write('log.png')

      image1 = Gtk::Image.new pixbuf: sfsdf
      fixed.put image1, 30, 30
    end

    fixed.put button, 50, 50

    set_title 'Quit button'
    signal_connect 'destroy' do
      Gtk.main_quit
    end

    set_default_size 300, 200
    set_window_position(:center)
    show_all
  end
end

RubyApp.new
Gtk.main
