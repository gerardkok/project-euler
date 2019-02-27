require 'csv'

def dijkstra(matrix)
  size = matrix.length
  unvisited = [[0, 0]]
  distances = Array.new(size) { |r| Array.new(size) { |c| (r.zero? && c.zero?) ? matrix[0][0] : Float::INFINITY } }

  r, c = unvisited.shift
  until r == size - 1 && c == size - 1
    neighbours = [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]].select { |x, y| x.between?(0, size - 1) && y.between?(0, size - 1) }
    neighbours.each do |rn, cn|
      d = distances[r][c] + matrix[rn][cn]
      next unless distances[rn][cn] > d

      distances[rn][cn] = d
      unvisited << [rn, cn]
    end
    unvisited.sort_by! { |x, y| distances[x][y] }
    r, c = unvisited.shift
  end
  distances[r][c]
end

matrix = CSV.read('input83.txt').map { |line| line.map(&:to_i) }

answer = dijkstra(matrix)

puts answer
