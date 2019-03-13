MAX_K = 12_000
MAX_N = 2 * MAX_K

factors = (2..MAX_N).each_with_object(Array.new(MAX_N + 1) { |_| [] }) do |n, acc|
  (n..MAX_N).step(n) do |f|
    acc[f] << n
  end
end

factorizations = (1..MAX_N).each_with_object(Array.new(MAX_N + 1) { |i| [[i]] }) do |n, acc|
  acc[n] += factors[n].flat_map { |f| acc[n / f].select { |i| i.none? { |j| j < f } }.map { |i| i + [f] } }
end

def k(factorization)
  factorization.length - factorization.reduce(:+) + factorization.reduce(:*)
end

minimal_product_sum_numbers = factorizations.each_with_index.each_with_object(Array.new(MAX_K + 1, Float::INFINITY)) do |(f, i), acc|
  f.each do |factorization|
    next if factorization.length == 1

    k = k(factorization)
    acc[k] = i if k <= MAX_K && i < acc[k]
  end
end

answer = minimal_product_sum_numbers.select { |k| k < Float::INFINITY }.uniq.reduce(:+)

puts answer
