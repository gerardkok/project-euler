N = 100

sumsquares = (1..N).map { |i| i**2 }.reduce(:+)
squaredsum = (1..N).reduce(:+)**2

answer = squaredsum - sumsquares

puts answer
