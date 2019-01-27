digit_cancelling_fractions = (1..8).each_with_object([]) do |n, memo|
  (n + 1..9).each do |d|
    digit_cancelled_fraction = Rational(n, d)
    # now try to find a digit 'e' that can be added to digit_cancelled_fraction
    # while not changing its value
    (n + 1..9).each do |e|
      fraction = Rational(10 * n + e, 10 * e + d)
      memo << fraction if fraction == digit_cancelled_fraction
    end
  end
end

answer = digit_cancelling_fractions.reduce(:*).denominator

puts answer
