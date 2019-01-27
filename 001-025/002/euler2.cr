fibonacci = [1, 1]
while fibonacci.last < 4E6
  fibonacci << fibonacci[-1] + fibonacci[-2]
end

answer = fibonacci.select(&.even?).sum

puts answer
