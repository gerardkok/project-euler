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

class SumSet
  include Enumerable

  def initialize(size, sum, set_prefix = [])
    @size = size
    @sum = sum
    @set_prefix = set_prefix
  end

  def each
    if @size == 1
      yield @set_prefix if @set_prefix.push(@sum).special?
    else
      min = @set_prefix.empty? ? @size - 1 : @set_prefix.last + 1
      max = (@sum - (@size * (@size - 1) >> 1)) / @size
      (min..max).each do |i|
        s = @set_prefix + [i]
        next unless s.special?

        self.class.new(@size - 1, @sum - i, s).each do |j|
          yield j
        end
      end
    end
  end
end

def find_sorted_sum_set(sum)
  SumSet.new(TARGET_SIZE, sum).find(&:any?)
end

start = [20, 31, 38, 39, 40, 42, 45].sum - 1
answer = start.step.lazy.map { |n| find_sorted_sum_set(n) }.find(&:itself).join.to_s

puts answer
