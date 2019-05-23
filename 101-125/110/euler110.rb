require 'prime'

def number_of_divisors_of_squared(number)
  Prime.prime_division(number).map(&:last).map { |i| 2 * i + 1 }.reduce(1, :*)
end

def exponents(n, max = n)
  return [[]] if n.zero?

  m = [n, max].min
  m.downto(1).flat_map do |i|
    exponents(n - i, i).map { |j| j.unshift(i) }
  end
end

def primorial_products_with_n_factors(n)
  exponents(n).map { |exps| Prime.first(exps.size).zip(exps).map { |p, e| p**e }.reduce(:*) }
end

answer = (1..18).flat_map { |n| primorial_products_with_n_factors(n) }.sort.find { |n| (number_of_divisors_of_squared(n) + 1) / 2 > 4_000_000 }

puts answer
