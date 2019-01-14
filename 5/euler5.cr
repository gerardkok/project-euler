answer = (1_i64..20_i64).reduce { |acc, i| acc.lcm(i) }

puts answer
