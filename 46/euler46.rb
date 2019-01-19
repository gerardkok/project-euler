require 'prime'

def potential_primes(number)
  1.step.lazy.map { |i| number - 2 * i**2 }.take_while(&:positive?).to_a
end

def counterexample?(number)
  potential_primes(number).none?(&:prime?)
end

answer = 3.step(by: 2).lazy.reject(&:prime?).find { |i| counterexample?(i) }

puts answer
