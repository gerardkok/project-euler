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

  def special_sum?
    !smaller_subsets_with_bigger_sums? && !subsets_with_equal_sums?
  end

  def sum
    reduce(:+)
  end
end

class SumSet
  include Enumerable

  def initialize(size, sum, minimum = 1)
    @size = size
    @sum = sum
    @minimum = minimum
  end

  def each
    if @size == 1
      yield [@sum]
    else
      (@minimum...(@sum + 1) / 2).each do |i|
        SumSet.new(@size - 1, @sum - i, i + 1).each do |j|
          yield [i] + j
        end
      end
    end
  end
end

def find_sorted_sum_set(sum)
  SumSet.new(TARGET_SIZE, sum).find(&:special_sum?)
end

start = [20, 31, 38, 39, 40, 42, 45].sum - 1
answer = start.step.lazy.map { |n| find_sorted_sum_set(n) }.find(&:itself).join.to_s

puts answer
