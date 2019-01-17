require 'prime'

def potential_primes(number)
  1.step.lazy.map { |i| number - 2 * i**2 }.take_while(&:positive?).to_a
end

def goldbachs_other_conjecture?(number)
  potential_primes(number).any?(&:prime?)
end

answer = 3.step(by: 2).lazy.reject(&:prime?).reject { |i| goldbachs_other_conjecture?(i) }.first

puts answer
