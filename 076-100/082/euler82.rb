require 'csv'

def min_path_length(matrix)
  size = matrix.length # assuming square matrix
  last_row_lengths = matrix.drop(1).reduce(matrix.first) do |result, row|
    (0...size).each_with_object(Array.new(size, Float::INFINITY)) do |i, r|
      r[i] = row[i] + result[i] if row[i] + result[i] < r[i]
      (i + 1...size).each do |j|
        range_sum = row[i..j].reduce(:+)
        r[i] = range_sum + result[j] if range_sum + result[j] < r[i]
        r[j] = range_sum + result[i] if range_sum + result[i] < r[j]
      end
    end
  end
  last_row_lengths.min
end

matrix = CSV.read('input82.txt').map { |line| line.map(&:to_i) }.transpose

answer = min_path_length(matrix)

puts answer
