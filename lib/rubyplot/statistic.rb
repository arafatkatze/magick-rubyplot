# This class defines a set of statistics functions that could prove to be helpful
# for plotting in the language.
class Array
  # Find the numeric mean. nils are ignored.
  def mean
    ary = to_a.compact
    if defined?(NMatrix) # Prefer the C version.
      ary.to_nm.mean[0]
    else                 # Fall back to Ruby.
      ary.inject(0) { |x, i| x + i } / ary.size.to_f
    end
  end

  # Find the single median or the mean of medians. nils are ignored.
  def median
    ary = to_a.compact.sort.uniq
    return nil if ary.empty?
    if ary.size.odd? # Even number of entries
      ary[(ary.size - 1) / 2]
    else # Odd number of entries
      idx = (ary.size - 1) / 2
      (ary[idx] + ary[idx + 1]) / 2.0
    end
  end

  # Find mode of an array
  def modes
    ary = sort.compact
    return nil if ary.empty?
    h = {}
    ary.each do |k|
      if h.key?(k)
        h[k] += 1
      else
        h[k] = 1
      end
    end
    return nil if h.keys.empty?
    max_key = h.keys.first
    h.each_pair do |k, count|
      next if count.nil? || h[max_key].nil?

      max_key = k if count > h[max_key]
    end

    mode_count = h[max_key]
    h.select { |_k, v| v == mode_count }.keys.sort
  end
end
