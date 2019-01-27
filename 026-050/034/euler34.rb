def factorial(n)
  (1..n).reduce(:*) || 1
end

def factorial_digit_sum(n)
  n.to_s.chars.map(&:to_i).map { |d| factorial(d) }.reduce(:+)
end

# 8*9! is a 7-digit number, so 7*9! is an upper bound
factorial_sums = (10..2_540_160).select do |n|
  n == factorial_digit_sum(n)
end

answer = factorial_sums.reduce(:+)

puts answer
