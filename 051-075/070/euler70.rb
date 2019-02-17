require 'prime'

def permutation?(one, other)
  one.to_s.chars.sort == other.to_s.chars.sort
end

# skip all primes p, q for which (p + q) % 9 != 1, because of the following:
# because 𝜑(n) is a permutation of n, the difference between them is divisible by 9 (see for example
# https://math.stackexchange.com/questions/1437918/show-that-n-m-is-a-multiple-of-9-when-n-and-m-have-same-digits)
# i.e. (n - 𝜑(n)) % 9 = 0, so in this case: (pq - (p - 1)(q - 1)) % 9 = 0
# simplifying gives: (pq - pq + p + q - 1) % 9 = 0, so (p + q) % 9 = 1
# note that not all numbers that differ by 9 are permutations of each other,
# so we still have to verify that 𝜑(n) is a permutation of n
permuted_totients = Prime.take_while { |p| p < Math.sqrt(1E7) }.each_with_object({}) do |p, result|
  Prime.take_while { |q| p * q < 1E7 }.drop_while { |q| q < p }.each do |q|
    next unless ((p + q) % 9) == 1

    totient = (p - 1) * (q - 1)
    number = p * q
    result[number] = totient if permutation?(number, totient)
  end
end

answer = permuted_totients.min_by { |number, totient| Rational(number, totient) }.first

puts answer
