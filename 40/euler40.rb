def digit_at(index)
  i = 0
  while index.positive?
    index -= 9 * (i + 1) * 10**i
    i += 1
  end
  number_at_index = 10**i + (index - 1) / i
  number_at_index.to_s[(index % i) - 1].to_i
end

answer = Array.new(7) { |i| 10**i }.map { |i| digit_at(i) }.reduce(:*)

puts answer
