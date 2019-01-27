require 'prime'

def pandigitals(range)
  range.to_a.permutation.map(&:join).map(&:to_i)
end

# pandigital primes with 2, 3, 5, 6, 8 or 9 digits are divisible by 3, so we
# only need to consider pandigital primes of 4 or 7 digits
pandigital_primes = (pandigitals(1..4) + pandigitals(1..7)).select(&:prime?)

answer = pandigital_primes.max

puts answer
