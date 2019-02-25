require 'bigdecimal'

class Integer
  def square?
    (Math.sqrt(self) % 1).zero?
  end

  def sqrt_digit_sum(precision = 100)
    BigDecimal(self).sqrt(precision).to_s[2..precision + 1].chars.map(&:to_i).reduce(:+)
  end
end

answer = (1..100).reject(&:square?).map(&:sqrt_digit_sum).reduce(:+)

puts answer
