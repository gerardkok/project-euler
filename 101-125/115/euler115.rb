BLOCK_SIZE = 50

number_of_block_combinations = Hash.new do |h, row_length|
  h[row_length] =
    if row_length < BLOCK_SIZE
      1
    else
      row_length_combinations = (0..row_length).map do |r|
        (BLOCK_SIZE..row_length - r).map { |b| h[row_length - r - b - 1] }.reduce(0, :+)
      end
      row_length_combinations.reduce(1, :+)
    end
end

answer = 1.step.find { |n| number_of_block_combinations[n] > 1_000_000 }

puts answer
