require 'prime'

def count_prime_summations(upto, primes = Prime.each(upto).to_a)
  return 1 if upto.zero?

  primes.reject { |p| p > upto }.each_with_index.reduce(0) do |sum, (p, i)|
    sum + count_prime_summations(upto - p, primes.first(i + 1))
  end
end

answer = 2.step.find { |n| count_prime_summations(n) > 5_000 }

puts answer
