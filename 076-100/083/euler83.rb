require 'csv'

def neighbours(r, c, max)
  [[r - 1, c], [r + 1, c], [r, c - 1], [r, c + 1]].select { |x, y| x.between?(0, max) && y.between?(0, max) }
end

def min_path_length(matrix)
  size = matrix.length # assuming square matrix
  unvisited = [[0, 0]]
  distances = Array.new(size) { |r| Array.new(size) { |c| (r.zero? && c.zero?) ? matrix[0][0] : Float::INFINITY } }

  until (r, c = unvisited.shift) == [size - 1, size - 1]
    neighbours(r, c, size - 1).each do |rn, cn|
      d = distances[r][c] + matrix[rn][cn]
      next unless distances[rn][cn] > d

      distances[rn][cn] = d
      unvisited << [rn, cn]
    end
    unvisited.sort_by! { |x, y| distances[x][y] }
  end
  distances[r][c]
end

matrix = CSV.read('input83.txt').map { |line| line.map(&:to_i) }

answer = min_path_length(matrix)

puts answer
