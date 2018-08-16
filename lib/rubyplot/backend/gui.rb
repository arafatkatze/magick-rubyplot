class GTK_Show < Gtk::Window
  def initialize
    super
  end

  def show_file(file_name)
    override_background_color :normal, Gdk::RGBA.new(0.2, 0.2, 0.2, 1)
    begin
      image = GdkPixbuf::Pixbuf.new file: file_name
    rescue IOError => e
      puts e
      puts 'cannot load images'
      exit
    end

    image1 = Gtk::Image.new pixbuf: image
    img = Magick::Image.read(file_name).first
    rows = img.rows + 35
    cols = img.columns

    fixed = Gtk::Fixed.new
    add fixed
    fixed.put image1, 0, 35

    button = Gtk::Button.new label: 'Quit'
    button.set_size_request 0, 0

    button.signal_connect 'clicked' do
      Gtk.main_quit
    end
    fixed.put button, 0, 0

    set_title 'Quit button'
    signal_connect 'destroy' do
      Gtk.main_quit
    end

    set_default_size cols, rows
    set_window_position(:center)
    show_all
  end
end
