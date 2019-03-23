def modinv(a, m)
  # see https://rosettacode.org/wiki/Category:Ruby
  # note that a and m are coprime in Farey sequences, so no need to verify
  return m if m == 1

  m0 = m
  inv = 1
  x0 = 0
  while a > 1
    quotient, m, a = *a.divmod(m), m
    inv, x0 = x0, inv - quotient * x0
  end
  inv % m0 # handle negative inv
end

def previous_farey_fraction(n, fraction)
  c = fraction.numerator
  d = fraction.denominator
  b0 = modinv(c, d)
  a0 = (c * b0 - 1) / d
  k = (n - b0) / d
  Rational(a0 + k * c, b0 + k * d)
end

answer = previous_farey_fraction(1_000_000, Rational(3, 7)).numerator

puts answer
