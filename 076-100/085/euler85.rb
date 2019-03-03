GRID_SIZE = 2_000_000

def count_rectangles(n, m)
  (n * (n + 1) * m * (m + 1)) / 4
end

grids = 1.step.reduce([]) do |acc, n|
  k = n * (n + 1)
  m = ((Math.sqrt(k * (k + 16 * GRID_SIZE)) - k) / (2 * k)).round
  break acc if n > m

  acc << [n, m]
end

x, y = grids.min_by { |n, m| (count_rectangles(n, m) - GRID_SIZE).abs }

answer = x * y

puts answer
