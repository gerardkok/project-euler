require "big"

answer = (1.to_big_i..100.to_big_i).product.digits.sum

puts answer
