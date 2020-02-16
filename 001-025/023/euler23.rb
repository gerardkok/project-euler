require 'prime'

class Integer
  def sum_proper_divisors
    # formula from https://www.mathblog.dk/project-euler-21-sum-of-amicable-pairs/
    division = Prime.prime_division(self)
    division.map { |p, a| (p**(a + 1) - 1) / (p - 1) }.reduce(:*) - self
  end

  def abundant?
    sum_proper_divisors > self
  end
end

UPPER_LIMIT = 28_123
ABUNDANTS = (2..UPPER_LIMIT).select(&:abundant?).freeze

abundant_sums = ABUNDANTS.each_with_object([]) do |a, acc|
  ABUNDANTS.each do |b|
    acc << a + b unless a + b > UPPER_LIMIT
  end
end

non_abundant_sums = (1..UPPER_LIMIT).to_a - abundant_sums

puts non_abundant_sums.sum
