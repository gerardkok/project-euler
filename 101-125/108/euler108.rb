require 'prime'

def number_of_divisors_of_squared(number)
  Prime.prime_division(number).map(&:last).map { |i| 2 * i + 1 }.reduce(1, :*)
end

answer = 1.step.find { |n| (number_of_divisors_of_squared(n) + 1) / 2 > 1_000 }

puts answer
