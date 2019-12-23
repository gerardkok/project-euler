MIN_BLOCK_SIZE = 2
MAX_BLOCK_SIZE = 4

class Array
  def sum
    reduce(0, :+)
  end
end

number_of_block_combinations = Hash.new do |h, row_length|
  remaining_combinations =
    if row_length < MIN_BLOCK_SIZE
      0
    else
      (MIN_BLOCK_SIZE..MAX_BLOCK_SIZE).map { |b| (0..row_length - b).map { |r| h[row_length - r - b] }.sum }.sum
    end
  h[row_length] = 1 + remaining_combinations
end

answer = number_of_block_combinations[50]

puts answer
