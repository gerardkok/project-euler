answer = (1..1_000).map { |i| i**i }.reduce(:+).to_s.chars.last(10).join

puts answer
