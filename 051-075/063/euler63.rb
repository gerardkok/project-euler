answer = (1..9).map { |a| (1 / (1 - Math.log10(a))).to_i }.reduce(:+)

puts answer
