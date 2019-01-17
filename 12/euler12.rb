require 'prime'

def triangle_number(index)
  index * (index + 1) / 2
end

def number_of_divisors(number)
  Prime.prime_division(number).map(&:last).map { |i| i + 1 }.reduce(1, :*)
end

def triangle_number_of_divisors(index)
  # index and index + 1 are coprime, so they don't share divisors
  return number_of_divisors(index / 2) * number_of_divisors(index + 1) if index.even?

  number_of_divisors(index) * number_of_divisors((index + 1) / 2)
end

answer = 1.step do |i|
  number_of_divisors = triangle_number_of_divisors(i)
  break triangle_number(i) if number_of_divisors > 500
end

puts answer
