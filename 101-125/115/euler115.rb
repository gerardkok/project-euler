BLOCK_SIZE = 50

class Array
  def sum
    reduce(0, :+)
  end
end

number_of_block_combinations = Hash.new do |h, row_length|
  remaining_combinations =
    if row_length < BLOCK_SIZE
      0
    else
      (0..row_length).map { |r| (BLOCK_SIZE..row_length - r).map { |b| h[row_length - r - b - 1] }.sum }.sum
    end
  h[row_length] = 1 + remaining_combinations
end

answer = 1.step.find { |n| number_of_block_combinations[n] > 1_000_000 }

puts answer
