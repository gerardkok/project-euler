def recurring_cycle_length(number, s = Math.sqrt(number).to_i, m = 0, d = 1, a = s)
  # see https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Algorithm
  return 0 if s**2 == number # number is perfect square

  return 0 if a == 2 * s # algorithm terminates normally

  m = d * a - m
  d = (number - m**2) / d
  a = ((s + m) / d).to_i
  recurring_cycle_length(number, s, m, d, a) + 1
end

answer = (1..10_000).map { |n| recurring_cycle_length(n) }.count(&:odd?)

puts answer
