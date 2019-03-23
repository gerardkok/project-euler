N = 1_000_000

sieve = (2..N).each_with_object((0..N).to_a) do |n, result|
  next unless result[n] == n

  result[n] -= 1
  (2 * n..N).step(n) do |p|
    result[p] = (result[p] * (n - 1)) / n
  end
end

answer = sieve[2..N].reduce(:+)

puts answer
