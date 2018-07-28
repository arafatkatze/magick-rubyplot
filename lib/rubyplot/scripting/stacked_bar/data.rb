class Rubyplot::StackedBar < Rubyplot::Bar
  DATA_VALUES_INDEX = Rubyplot::Artist::DATA_VALUES_INDEX
  def max_stack_height
    # Get the sum of values in each stack to the get the stack height
    max_hash = {}
    @data.each do |data_set|
      data_set[DATA_VALUES_INDEX].each_with_index do |data_point, i|
        max_hash[i] = 0.0 unless max_hash[i]
        max_hash[i] += data_point.to_f
      end
    end

    @geometry.maximum_value = 0
    max_hash.keys.each do |key|
      @geometry.maximum_value = max_hash[key] if max_hash[key] > @geometry.maximum_value
    end
    @geometry.minimum_value = 0
  end
end
