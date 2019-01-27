answer = (0..9).to_a.permutation.sort[999_999].reduce { |n, d| n * 10 + d }

puts answer
