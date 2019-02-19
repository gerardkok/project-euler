N = 1_000_000

sieve = (0..N).to_a

(2..N).each do |n|
  if sieve[n] == n
    sieve[n] -= 1
    (2 * n..N).step(n).each do |p|
      sieve[p] = (sieve[p] * (n - 1)) / n
    end
  end
end

#puts sieve.to_s

puts sieve[2..N].reduce(:+)