answer = (1..1000).select { |i| (i % 3).zero? || (i % 5).zero? }.reduce(:+)

puts answer
