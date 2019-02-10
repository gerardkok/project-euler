def id(number)
  number.to_s.chars.sort
end

cubics = 1.step.lazy.map { |i| i**3 }.each_with_object({}) do |c, result|
  id = id(c)
  (result[id] ||= []) << c
  break result if result[id].length == 5
end

answer = cubics.values.select { |c| c.length == 5 }.sample.min

puts answer
