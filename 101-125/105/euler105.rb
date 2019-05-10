class Array
  @masks = Hash.new do |h, size|
    h[size] = (2..size / 2).each_with_object([]) do |k, memo|
      (0..size - 1).to_a.combination(k).each do |s1|
        elements_left = (0..size - 1).to_a - s1
        elements_left.combination(k).each do |s2|
          next if s1.first > s2.first # skip mirrors

          memo << [s1, s2] unless s1.zip(s2).all? { |x, y| x < y }
        end
      end
    end
  end

  class << self
    attr_reader :masks
  end

  def smaller_subsets_with_bigger_sums?
    (2..size / 2 + 1).any? { |l| self[0...l].sum <= self[1 - l..-1].sum }
  end

  def subsets_with_equal_sums?
    Array.masks[size].any? do |s1, s2|
      values_at(*s1).sum == values_at(*s2).sum
    end
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
