def sundays_in_year(year)
  (1..12).select { |month| Time.new(year, month, 1).sunday? }.size
end

answer = (1901..2000).map { |year| sundays_in_year(year) }.sum

puts answer
