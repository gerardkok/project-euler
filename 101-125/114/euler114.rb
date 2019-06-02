number_of_block_combinations = Hash.new do |h, (remaining_row_length, minimum_block_size)|
  h[[remaining_row_length, minimum_block_size]] =
    if minimum_block_size > remaining_row_length
      1
    else
      (0..remaining_row_length).reduce(1) do |remaining_row_sum, r|
        block_size_combinations = (minimum_block_size..remaining_row_length - r).reduce(0) do |block_size_sum, b|
          block_size_sum + h[[remaining_row_length - r - b - 1, minimum_block_size]]
        end
        remaining_row_sum + block_size_combinations
      end
    end
end

answer = number_of_block_combinations[[50, 3]]

puts answer
