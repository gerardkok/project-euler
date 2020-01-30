require 'date'

def count_sundays_in_year(year)
  (1..12).count { |month| Date.new(year, month, 1).sunday? }
end

answer = (1901..2000).map { |year| count_sundays_in_year(year) }.sum

puts answer
