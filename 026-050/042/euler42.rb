require 'csv'

class Integer
  def square?
    (Math.sqrt(self) % 1).zero?
  end

  def triangular?
    (8 * self + 1).square?
  end
end

class String
  LETTER_VALUES = ('A'..'Z').zip(1..26).to_h.freeze

  def triangular?
    LETTER_VALUES.values_at(*chars).reduce(:+).triangular?
  end
end

answer = CSV.read('input42.txt').first.count(&:triangular?)

puts answer
