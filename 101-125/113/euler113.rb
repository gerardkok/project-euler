# see https://github.com/nayuki/Project-Euler-solutions/blob/master/python/p113.py

N = 100

def choose(n, k)
  (n - k + 1..n).reduce(:*) / (1..k).reduce(:*)
end

def number_of_increasing_numbers(n)
  choose(n + 9, 9) - 1
end

def number_of_decreasing_numbers(n)
  choose(n + 10, 10) - (n + 1)
end

def number_of_flat_numbers(n)
  9 * n
end

def number_of_non_bouncy_numbers(n)
  number_of_increasing_numbers(n) + number_of_decreasing_numbers(n) - number_of_flat_numbers(n)
end

answer = number_of_non_bouncy_numbers(N)

puts answer
