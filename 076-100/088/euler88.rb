MAX_K = 12_000
MAX_N = 2 * MAX_K

factors = (2..MAX_N).each_with_object(Array.new(MAX_N + 1) { [] }) do |n, acc|
  (n * n..MAX_N).step(n) do |f|
    acc[f] << n
  end
end

partial_sums = (1..MAX_N).each_with_object(Array.new(MAX_N + 1) { |i| [1 - i] }) do |n, acc|
  acc[n] += factors[n].flat_map { |f| acc[n / f].map { |i| i + 1 - f }.reject { |p| p > MAX_K - n } }.uniq
end

minimal_product_sum_numbers = (2..MAX_N).each_with_object(Array.new(MAX_K + 1, Float::INFINITY)) do |i, acc|
  partial_sums[i].drop(1).map { |partial_sum| partial_sum + i }.each do |k|
    acc[k] = i if i < acc[k]
  end
end

answer = minimal_product_sum_numbers.drop(2).uniq.reduce(:+)

puts answer
