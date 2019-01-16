require 'prime'

answer = Prime.each(2_000_000).reduce(:+)

puts answer
