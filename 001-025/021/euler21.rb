require 'prime'

class Integer
  def sum_proper_divisors
    # formula from https://www.mathblog.dk/project-euler-21-sum-of-amicable-pairs/
    division = Prime.prime_division(self)
    division.map { |p, a| (p**(a + 1) - 1) / (p - 1) }.reduce(:*) - self
  end

  def amicable?
    a = sum_proper_divisors
    a > 1 && a != self && a.sum_proper_divisors == self
  end
end

answer = (2..10_000).select(&:amicable?).sum

puts answer
