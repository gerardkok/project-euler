def id(number)
  number.to_s.chars.sort
end

cubics = 1.to_i64.step.map { |i| i**3 }.each_with_object({} of Array(Char) => Array(Int64)) do |c, result|
  id = id(c)
  (result[id] ||= [] of Int64) << c
  break result if result[id].size == 5
end

answer = cubics.values.select { |c| c.size == 5 }.sample.min

puts answer
