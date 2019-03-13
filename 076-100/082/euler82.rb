require 'csv'

def min_path_length(matrix)
  size = matrix.length  # assuming square matrix
  min_paths_per_row = (size - 2).downto(0).each_with_object(matrix.map(&:last)) do |column, acc|
    acc[0] += matrix.first[column]
    (0...size).each_cons(2) do |upper, row|
      acc[row] = [acc[upper], acc[row]].min + matrix[row][column]
    end
    (size - 1).downto(0).each_cons(2) do |lower, row|
      acc[row] = [acc[row], acc[lower] + matrix[row][column]].min
    end
  end
  min_paths_per_row.min
end

matrix = CSV.read('input82.txt').map { |line| line.map(&:to_i) }

answer = min_path_length(matrix)

puts answer
