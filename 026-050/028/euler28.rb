def sum_of_corners(spiral_index)
  return 1 if spiral_index == 1

  16 * (spiral_index**2) - 28 * spiral_index + 16
end

answer = (1..501).map { |i| sum_of_corners(i) }.reduce(:+)

puts answer
