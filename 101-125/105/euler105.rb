require 'set'

class Array
  def smaller_subsets_with_bigger_sums?
    l = size / 2 + 1
    self[0...l].sum <= self[1 - l..-1].sum
  end

  def subsets_with_equal_sums?
    (2..size / 2).each do |k|
      combination(k).map(&:sum).reduce([].to_set) do |memo, v|
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

special_sum_sets = File.open('input105.txt').map { |line| line.split(',').map(&:to_i).sort }.select(&:special_sum?)

answer = special_sum_sets.map(&:sum).sum

puts answer
