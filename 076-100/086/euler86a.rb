MAX_M = 100
MAX_C = (Math.sqrt(5) * MAX_M).to_i

def number_of_paths(l, bh, cuboid_shortest_paths)
  max_l = MAX_M / l
  (1..max_l).each do |i|
    number_of_paths = (bh <= l) ? i * bh / 2 : 1 + (i * l - (i * bh + 1) / 2)
    cuboid_shortest_paths[i * l] += number_of_paths
  end
end

cuboid_shortest_paths = begin
  m_n = [[2, 1]]
  cuboid_shortest_paths = Array.new(MAX_M + 1, 0)
  loop do
    m_n.each do |m, n|
      a = m**2 - n**2
      b = 2 * m * n
      if b < 2 * a
        number_of_paths(a, b, cuboid_shortest_paths)
      end
      if a < 2 * b
        number_of_paths(b, a, cuboid_shortest_paths)
      end
    end
    m_n = m_n.flat_map { |m, n| [[2 * m - n, m], [2 * m + n, m], [m + 2 * n, n]] }.select { |m, n| m**2 + n**2 <= MAX_C }
    break cuboid_shortest_paths if m_n.empty?
  end
end

acc_shortest_paths = (1..MAX_M).reduce([0]) do |acc, i|
  acc << acc[-1] + cuboid_shortest_paths[i]
end

(1..MAX_M).each do |i|
  puts "[#{i}]: cuboid: #{cuboid_shortest_paths[i]}, accumulated: #{acc_shortest_paths[i]}"
end

# a = m**2 - n**2
# b = 2 * m * n
# c = m**2 + n**2
# count = MAX_C / c
# 1.upto(count) do |i|
#   a1 = i * a
#   b1 = i * b
#   c1 = i * c
#   short = (a1 <= MAX_M && b1 <= 2 * a1) ? [[a1, b1, c1]] : []
#   long = (b1 <= MAX_M && a1 <= 2 * b1) ? [[b1, a1, c1]] : []
#   cuboid_shortest_paths += (short + long)
# end
