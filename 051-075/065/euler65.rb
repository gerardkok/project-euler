def e_continued_fraction(index)
  return 2 if index.zero?

  d, m = index.divmod(3)
  if m == 2
    (d + 1) * 2
  else
    1
  end
end

def e_convergent_fraction(index, upto)
  return e_continued_fraction(index) if index == upto

  e_continued_fraction(index) + Rational(1, e_convergent_fraction(index + 1, upto))
end

hundredth_term = e_convergent_fraction(0, 99)

answer = hundredth_term.numerator.to_s.chars.map(&:to_i).reduce(:+)

puts answer
