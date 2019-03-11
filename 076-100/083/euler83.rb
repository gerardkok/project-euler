require 'csv'

class PriorityQueue
  def initialize(size)
    @elements = [nil]
    @distances = Array.new(size) { |_| Array.new(size, Float::INFINITY) }
  end

  def push(row, column, distance)
    @elements << [row, column]
    @distances[row][column] = distance
    float
  end

  def length
    @elements.size - 1
  end

  def empty?
    length.zero?
  end

  def pop
    swap(1, length)
    e = @elements.pop
    sink
    e
  end

  def [](row, column)
    @distances[row][column]
  end

  private

  def float
    k = length
    while (j = k) > 1 && heavier?(k >> 1, j)
      k >>= 1
      swap(j, k)
    end
  end

  def sink
    k = 1
    while (j = 2 * k) <= length
      j += 1 if j < length && heavier?(j, j + 1)
      return if lighter?(k, j)

      swap(k, j)
      k = j
    end
  end

  def swap(i, j)
    @elements[i], @elements[j] = @elements[j], @elements[i]
  end

  def heavier?(i, j)
    self[*@elements[i]] > self[*@elements[j]]
  end

  def lighter?(i, j)
    self[*@elements[i]] < self[*@elements[j]]
  end
end

def left_neighbour(r, c, unvisited, matrix)
  d = unvisited[r, c] + matrix[r - 1][c]
  unvisited.push(r - 1, c, d) if unvisited[r - 1, c] > d
end

def right_neighbour(r, c, unvisited, matrix)
  d = unvisited[r, c] + matrix[r + 1][c]
  unvisited.push(r + 1, c, d) if unvisited[r + 1, c] > d
end

def upper_neighbour(r, c, unvisited, matrix)
  d = unvisited[r, c] + matrix[r][c - 1]
  unvisited.push(r, c - 1, d) if unvisited[r, c - 1] > d
end

def lower_neighbour(r, c, unvisited, matrix)
  d = unvisited[r, c] + matrix[r][c + 1]
  unvisited.push(r, c + 1, d) if unvisited[r, c + 1] > d
end

def min_path_length(matrix, size = matrix.length)
  unvisited = PriorityQueue.new(size)
  unvisited.push(0, 0, matrix[0][0])
  max = size - 1

  until (r, c = unvisited.pop) == [max, max]
    left_neighbour(r, c, unvisited, matrix) unless r.zero?
    right_neighbour(r, c, unvisited, matrix) unless r == max
    upper_neighbour(r, c, unvisited, matrix) unless c.zero?
    lower_neighbour(r, c, unvisited, matrix) unless c == max
  end
  unvisited[max, max]
end

matrix = CSV.read('input83.txt').map { |line| line.map(&:to_i) }

answer = min_path_length(matrix)

puts answer
