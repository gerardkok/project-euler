require 'prime'

def number_of_primes(a, b)
  (0..b).each do |n|
    f = n * n + a * n + b
    return n - 1 unless f.prime?
  end
  b
end

products_of_coefficients = (-1000..1000).each_with_object({}) do |a, memo|
  Prime.each(1000) do |b|
    memo[a * b] = number_of_primes(a, b)
  end
end

answer = products_of_coefficients.max_by { |_, v| v }.first

puts answer
