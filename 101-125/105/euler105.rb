class Array
  @masks = Hash.new do |h, size|
    h[size] = (2..size / 2).each_with_object([]) do |k, memo|
      (0..size - 1).to_a.combination(k).each do |s1|
        elements_left = (0..size - 1).to_a - s1
        elements_left.combination(k).each do |s2|
          next if s1.first > s2.first

          memo << [s1, s2] unless s1.zip(s2).all? { |x, y| x < y }
        end
      end
    end
  end

  class << self
    attr_reader :masks
  end

  def smaller_subsets_with_bigger_sums?
    (2..size / 2 + 1).any? { |l| self[0...l].reduce(:+) <= self[1 - l..-1].reduce(:+) }
  end

  def subsets_with_equal_sums?
    Array.masks[size].any? do |s1, s2|
      values_at(*s1).reduce(:+) == values_at(*s2).reduce(:+)
    end
  end

  def special_sum?
    !smaller_subsets_with_bigger_sums? && !subsets_with_equal_sums?
  end
end

lines = File.open('input105.txt').readlines.map(&:chomp)

answer = lines.map { |line| line.split(',').map(&:to_i) }.map(&:sort).select(&:special_sum?).map { |set| set.reduce(:+) }.reduce(:+)

puts answer
