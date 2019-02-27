require 'csv'

def min_path_length(matrix)
  size = matrix.length # assuming square matrix
  initial = Array.new(size) { |i| i.zero? ? 0 : Float::INFINITY }
  lengths = (0...size).reduce(initial) do |result, row|
    (1...size).reduce([result.first + matrix[row].first]) do |row_so_far, i|
      row_so_far << [row_so_far.last, result[i]].min + matrix[row][i]
    end
  end
  lengths.last
end

matrix = CSV.read('input81.txt').map { |line| line.map(&:to_i) }

answer = min_path_length(matrix)

puts answer
