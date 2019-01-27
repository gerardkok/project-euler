class Integer
  def hexagonal?
    (((Math.sqrt(8 * self + 1) + 1) / 4) % 1).zero?
  end

  def pentagonal?
    (((Math.sqrt(24 * self + 1) + 1) / 6) % 1).zero?
  end

  def square?
    (Math.sqrt(self) % 1).zero?
  end

  def triangular?
    (8 * self + 1).square?
  end
end

def hexagonal_number(index)
  index * (2 * index - 1)
end

answer = 144.step.lazy.map { |h| hexagonal_number(h) }.select(&:pentagonal?).find(&:triangular?)

puts answer
