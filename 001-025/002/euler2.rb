fibonacci = [1, 1]
fibonacci << fibonacci[-1] + fibonacci[-2] while fibonacci.last < 4E6

answer = fibonacci.select(&:even?).reduce(:+)

puts answer
