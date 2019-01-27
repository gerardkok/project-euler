def sum_of_fifth_powers(number)
  number.to_s.chars.map(&:to_i).map { |d| d**5 }.reduce(:+)
end

answer = (2..1_000_000).select { |n| n == sum_of_fifth_powers(n) }.reduce(:+)

puts answer
