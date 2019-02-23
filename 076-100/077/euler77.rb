require 'prime'

def combine(upto, primes = Prime.each(upto).to_a)
  return 0 if primes.empty?

  prime = primes.first
  return 1 if upto == prime
  return 0 if upto < prime

  combine(upto - prime, primes) + combine(upto, primes[1..-1])
end

answer = 2.step.find { |n| combine(n) > 5_000 }

puts answer
