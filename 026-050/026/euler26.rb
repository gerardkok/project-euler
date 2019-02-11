def recurring_cycle_length(denominator, numerator = 1, decimal_fraction = [])
  first_occurrence = decimal_fraction.index(numerator)
  return decimal_fraction.length - first_occurrence if first_occurrence

  rest = (10 * numerator) % denominator
  return 0 if rest.zero?

  recurring_cycle_length(denominator, rest, decimal_fraction << numerator)
end

answer = (2..1_000).max_by { |n| recurring_cycle_length(n) }

puts answer
