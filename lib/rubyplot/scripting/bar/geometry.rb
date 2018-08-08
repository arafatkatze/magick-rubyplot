module Rubyplot
  class BarGeometry < Rubyplot::ArtistGeometry
    attr_accessor :spacing_factor
    def initialize(*)
      super
      @spacing_factor = 0.9
    end
  end
end
