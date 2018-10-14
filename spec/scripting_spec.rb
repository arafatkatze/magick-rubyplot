RubyplotSpec.describe Rubyplot::Figure do
  context '#scatter!', focus: true do
    before do
      @x1 = [1, 2, 3, 4, 5]
      @y1 = [11, 2, 33, 4, 65]
    end
    
    it 'creates a simple scatter plot' do
      a = Rubyplot::Figure.new
      a.scatter!(400) do |p| 
        p.data @x1, @y1, label: :data1, color: :plum_purple
      end

      if Rubyplot.backend == :magick
        a.save 'spec/reference_images/file_magick.png'
        expect("file_magick.png").to eq_image('scatter.png', 10)
      elsif Rubyplot.backend == :GR
        a.save 'spec/reference_images/file_gr.bmp'
        expect("file_gr.bmp").to eq_image('gr/single_plot_graph/scatter_graph.bmp', 10)
      end
    end
  end

  context "#subplot!" do
    it "creates a 1x2 subplot" do
      a = Rubyplot::Figure.new
      a.subplot!(1, 2, 1)
      a.line! do |p|
        p.title = "A line graph."
        p.data [1, 2, 3, 4, 5], label: :marco, color: :blue
        p.data [1, 53, 76, 18], label: :john, color: :green
      end
      
      a.subplot!(1, 2, 2)
      a.scatter! do |p|
        p.data [1, 2, 3, 4, 5], [11, 2, 33, 4, 66], label: :data1, color: :plum_purple
      end

      if Rubyplot.backend == :magick
        a.save 'spec/reference_images/file.png'
        expect("file.png").to eq_image('subplot1_test.png', 10)
      elsif Rubyplot.backend == :GR
      end
    end
  end
end
