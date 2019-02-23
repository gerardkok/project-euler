require 'prime'

def combine(upto, primes = Prime.each(upto).to_a)
  return 1 if upto.zero?
  return 0 if upto.negative?

  primes.each_with_index.reduce(0) do |sum, (p, i)|
    sum + combine(upto - p, primes[i..-1])
  end
end

answer = 2.step.find { |n| combine(n) > 5_000 }

puts answer
