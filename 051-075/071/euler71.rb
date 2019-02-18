max = (1..1_000_000).map { |d| [d * 3 / 7, d] }.select { |n, d| n.gcd(d) == 1 }.map { |n, d| Rational(n, d) }.select { |r| r < Rational(3, 7) }.max

answer = max.numerator

puts answer
