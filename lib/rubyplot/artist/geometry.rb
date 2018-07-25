module Rubyplot
  class ArtistGeometry
    # Used for navigating the array of data to plot
    DATA_LABEL_INDEX = 0
    DATA_VALUES_INDEX = 1
    DATA_COLOR_INDEX = 2
    DATA_VALUES_X_INDEX = 3
    LABEL_MARGIN = 10.0
    DEFAULT_MARGIN = 20.0

    # Blank space above the graph
    attr_accessor :top_margin
    attr_accessor :labels, :labels_seen, :increment, :increment_scaled
    attr_accessor :use_data_label, :legend_box_size
    def initialize(*)
      @spacing_factor = 0.9
      @top_margin = DEFAULT_MARGIN
      @use_data_label = false
    end
  end
end
