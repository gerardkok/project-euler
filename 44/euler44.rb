class Integer
  def pentagonal?
    i = Math.sqrt(24 * self + 1)
    (i % 1).zero? && (i % 6 == 5)
  end
end

def pentagonal_number(index)
  index * (3 * index - 1) / 2
end

def smallest_pentagonal_difference(index)
  n = pentagonal_number(index)
  (1...index).map { |p| pentagonal_number(p) }.each do |m|
    sum = n + m
    difference = n - m
    return difference if difference.pentagonal? && sum.pentagonal?
  end
  0 # because 0 is not a pentagonal number, we can use it to denote 'not found'
end

answer = 2.step.lazy.map { |p| smallest_pentagonal_difference(p) }.find(&:positive?)

puts answer
