require 'csv'

def row_range_sum(row, i, j)
  lower, upper = (j < i) ? [j, i] : [i, j]
  row[lower..upper].reduce(:+)
end

def min_path_length(matrix)
  size = matrix.length # assuming square matrix
  initial = Array.new(size, 0)
  lengths = matrix.reduce(initial) do |result, row|
    (0...size).map do |i|
      (0...size).map { |j| row_range_sum(row, i, j) + result[j] }.min
    end
  end
  lengths.min
end

matrix = CSV.read('input82.txt').map { |line| line.map(&:to_i) }.transpose

answer = min_path_length(matrix)

puts answer
