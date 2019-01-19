require 'prime'

def number_of_prime_factors(number)
  Prime.prime_division(number).length
end

def four_factor_consecutive?(range)
  range.all? { |n| number_of_prime_factors(n) == 4 }
end

answer = 2.step.lazy.each_cons(4).find { |r| four_factor_consecutive?(r) }.first

puts answer
