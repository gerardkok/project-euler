require "prime"
 
answer = Prime.each.reduce do |result, prime|
  product = result * prime
  break result if product > 1_000_000

  product
end

puts answer
