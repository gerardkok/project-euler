BLOCK_SIZE = 3

number_of_block_combinations = Hash.new do |h, remaining_row_length|
  h[remaining_row_length] =
    if remaining_row_length < BLOCK_SIZE
      1
    else
      (0..remaining_row_length).reduce(1) do |remaining_row_sum, r|
        block_size_combinations = (BLOCK_SIZE..remaining_row_length - r).reduce(0) do |block_size_sum, b|
          block_size_sum + h[remaining_row_length - r - b - 1]
        end
        remaining_row_sum + block_size_combinations
      end
    end
end

answer = number_of_block_combinations[50]

puts answer
