require 'prime'

MAX_K = 12_000
MAX_N = 2 * MAX_K

factors = (2..MAX_N).each_with_object(Array.new(MAX_N + 1) { |_| [] }) do |n, acc|
  (n..MAX_N).step(n) do |f|
    acc[f] << n
  end
end

#puts factors.to_s

factorizations = (1..MAX_N).each_with_object({}) do |n, acc|
  acc[n] = [[n]]
  factors[n].each do |f|
    acc[n / f].each do |i|
      acc[n] << i + [f] if i.none? { |j| j < f }
    end
  end
end

#puts factorizations.to_s

def k(factorization)
  factorization.length - factorization.reduce(:+) + factorization.reduce(:*)
end

k = factorizations.each_with_object(Array.new(MAX_K + 1, Float::INFINITY)) do |(i, f), acc|
  f.each do |factorization|
    next if factorization.length == 1
    k_fact = k(factorization)
    acc[k_fact] = i if k_fact <= MAX_K && i < acc[k_fact]
  end
end

#puts k.to_s

puts k.select { |i| i < Float::INFINITY }.uniq.reduce(:+)
