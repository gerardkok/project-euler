SIZE = 5

def last_index_in_line(i)
  (i + SIZE + 1) % SIZE + SIZE
end

class Array
  def line(i)
    [self[i], self[i + SIZE], self[last_index_in_line(i)]]
  end

  def sum_line(i)
    line(i).reduce(:+)
  end

  def magic_gon?
    sum_first_line = sum_line(0)
    (1...SIZE).all? { |i| sum_line(i) == sum_first_line }
  end

  def lowest_external_first?
    self[1...SIZE].all? { |n| n > first }
  end

  def max_node_external?
    self[0...SIZE].include?(2 * SIZE)
  end

  def acceptable?
    max_node_external? && lowest_external_first? && magic_gon?
  end

  def to_i
    (0...SIZE).flat_map { |i| line(i) }.map(&:to_s).join.to_i
  end
end

answer = (1..2 * SIZE).to_a.permutation.select(&:acceptable?).map(&:to_i).max

puts answer
