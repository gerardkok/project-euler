def modinv(a, m)
  # see https://rosettacode.org/wiki/Category:Ruby
  # note that a and m are coprime in Farey sequences, so no need to verify
  return m if m == 1

  m0 = m
  inv = 1
  x0 = 0
  while a > 1
    quotient, remainder = a.divmod(m)
    a = m
    m = remainder
    inv, x0 = x0, inv - quotient * x0
  end
  (inv + m0) % m0 # handle negative inv
end

def next_farey_fraction(n, fraction)
  a = fraction.numerator
  b = fraction.denominator
  c0 = modinv(a, b)
  d0 = (b * c0 - 1) / a
  k = (n - d0) / b
  Rational(c0 + k * a, d0 + k * b)
end

def farey(n, lower, upper)
  b = lower.denominator
  d = next_farey_fraction(n, lower).denominator
  result = 0
  while d != upper.denominator
    k = (n + b) / d
    b, d = d, k * d - b
    result += 1
  end
  result
end

answer = farey(12_000, Rational(1, 3), Rational(1, 2))

puts answer
