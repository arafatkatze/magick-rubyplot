module Rubyplot
  module Scripting
    module Plots
      # All plots are derived from a BasePlot. Currently there are two types of
      # plots Robust Plots that derive from RobustBase and Lazy Plots that
      # derive from LazyBase.
      module BasePlots
        # Base class for Robust Plots.
        #
        # Robust plots are the plots which are independent of the state of the
        # Figure.
        #
        # For example: A scatter plot is independent of the location of axes.
        # Plots which are Sub classes of RobustBase append the instances of GR
        # function classes to tasks when initialised.
        # These instances are called via the call method defined in RobustBase.
        #
        class RobustBase
          include Rubyplot::GRWrapper::Tasks
          include Rubyplot::Color
          attr_reader :plot_type
          def initialize
            @tasks = []
            @plot_type = :robust
          end

          def call
            @tasks.each(&:call)
          end
        end
        # Base class for Lazy plots.
        #
        # Lazy plots are the plots which are dependent on the state of Figure
        #
        # For example: A bar graphs base would depend on the location of axes
        # which is determined when the figure is viewed or saved.
        #
        # In Lazy plots the state of the Figure is passed when they are called
        # from PlotSpace
        # Every lazy plot has a unique call function rather than inherting it
        # from LazyBase.
        # In LazyPlots the instances of GR Function Classes are called as soon
        # as they are instantiated. This all is done in the call function
        #
        #
        class LazyBase
          include Rubyplot::GRWrapper::Tasks
          include Rubyplot::Color
          attr_reader :plot_type
          def initialize
            @plot_type = :lazy
          end
        end
      end
    end
  end
end
