require 'prime'

PRIMES = Prime.take_while { |p| p < 1_000_000 }.to_a.freeze

consecutive_prime_sums = begin
  sums = []
  (0...PRIMES.length).each_with_object([]) do |l, memo|
    (0...PRIMES.length - l).each do |i|
      p = sums.fetch(i, 0) + PRIMES[i + l]
      break unless p < 1_000_000

      sums[i] = p
      memo << [i, l + 1] if p.prime?
    end
  end
end

start_index, length = consecutive_prime_sums.max_by { |_, l| l }

answer = PRIMES[start_index, length].reduce(:+)

puts answer
