require 'date'

def sundays_in_year(year)
  (1..12).select { |month| Date.new(year, month, 1).sunday? }.length
end

answer = (1901..2000).map { |year| sundays_in_year(year) }.reduce(:+)

puts answer
