module Rubyplot
  class BarGeometry < Rubyplot::ArtistGeometry
    attr_accessor :spacing_factor
    def initialize(*)
      @spacing_factor = 0.9
    end
  end
end
