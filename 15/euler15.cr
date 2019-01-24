require "big"

def choose(n : BigInt, k : BigInt) : BigInt
  (n - k + 1..n).product / (1.to_big_i..k).product
end

answer = choose(40.to_big_i, 20.to_big_i)

puts answer
