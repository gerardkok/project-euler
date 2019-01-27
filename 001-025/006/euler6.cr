N = 100

sumsquares = (1..N).map { |i| i**2 }.sum
squaredsum = (1..N).sum**2

answer = squaredsum - sumsquares

puts answer
