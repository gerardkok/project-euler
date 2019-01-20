require 'prime'

PRIMES = Prime.take_while { |p| p < 1_000_000 }.to_a.freeze

def max_consecutive_prime_sums
  sums = []
  (0...PRIMES.length).each_with_object([]) do |l, memo|
    (0...PRIMES.length - l).each do |i|
      p = sums.fetch(i, 0) + PRIMES[i + l]
      break unless p < 1_000_000

      sums[i] = p
      memo << [i, l] if p.prime?
    end
  end
end

start_index, length = max_consecutive_prime_sums.max_by { |_, l| l }

answer = PRIMES[start_index..start_index + length].reduce(:+)

puts answer
