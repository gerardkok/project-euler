require 'set'

TARGET_SIZE = 7

class Array
  def smaller_subsets_with_bigger_sums?
    l = size / 2 + 1
    self[0...l].sum <= self[1 - l..-1].sum
  end

  def subsets_with_equal_sums?
    (2..size / 2).each do |k|
      combination(k).reduce([].to_set) do |memo, s|
        v = s.sum
        return true if memo.include?(v)

        memo << v
      end
    end
    false
  end

  def special?
    return true if size <= 2

    !smaller_subsets_with_bigger_sums? && !subsets_with_equal_sums?
  end

  def sum
    reduce(:+)
  end
end

special_sum_sets = Hash.new do |h, (size, sum)|
  h[[size, sum]] =
    if size == 1
      [[sum]]
    else
      min = size - 1
      max = (sum - (size * (size - 1) >> 1)) / size
      (min..max).each_with_object([]) do |i, memo|
        h[[min, sum - i]].each do |s|
          next unless i < s.first

          t = [i] + s
          memo << t if t.special?
        end
      end
    end
end

# 2^n for target size n is a lower bound,
# see https://github.com/nayuki/Project-Euler-solutions/blob/master/python/p103.py
start = 1 << TARGET_SIZE
answer = start.step.lazy.map { |n| special_sum_sets[[TARGET_SIZE, n]] }.find(&:any?).join.to_s

puts answer
