class Array
  def sum
    reduce(0, :+)
  end
end

def number_of_combinations(cached_combinations, row_length, block_size)
  return 0 if row_length < block_size

  (0..row_length - block_size).map { |r| cached_combinations[r] + 1 }.sum
end

number_of_red_combinations = Hash.new { |h, row_length| h[row_length] = number_of_combinations(h, row_length, 2) }

number_of_green_combinations = Hash.new { |h, row_length| h[row_length] = number_of_combinations(h, row_length, 3) }

number_of_blue_combinations = Hash.new { |h, row_length| h[row_length] = number_of_combinations(h, row_length, 4) }

number_of_block_combinations = Hash.new do |h, row_length|
  h[row_length] =
    number_of_red_combinations[row_length] + number_of_green_combinations[row_length] + number_of_blue_combinations[row_length]
end

answer = number_of_block_combinations[50]

puts answer
