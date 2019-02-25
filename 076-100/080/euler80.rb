require 'bigdecimal/math'

class Integer
  include BigMath

  def square?
    (Math.sqrt(self) % 1).zero?
  end

  def sqrt_digit_sum(precision = 100)
    BigMath.sqrt(BigDecimal(self), precision).to_s('F').sub('.', '')[0...precision].chars.map(&:to_i).reduce(:+)
  end
end

answer = (1..100).reject(&:square?).map(&:sqrt_digit_sum).reduce(:+)

puts answer
