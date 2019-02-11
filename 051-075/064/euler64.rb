def recurring_cycle_length(number, m = 0, d = 1, continued_fraction = nil)
  # see https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Algorithm
  a0 = Math.sqrt(number).to_i
  return 0 if a0**2 == number

  continued_fraction ||= [a0]
  a = continued_fraction.last
  return continued_fraction.length - 1 if a == 2 * a0

  m = d * a - m
  d = (number - m**2) / d
  a = ((a0 + m) / d).to_i
  recurring_cycle_length(number, m, d, continued_fraction << a)
end

answer = (1..10_000).map { |n| recurring_cycle_length(n) }.count(&:odd?)

puts answer
