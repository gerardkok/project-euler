class Integer
  def digital_sum
    to_s.chars.map(&:to_i).reduce(:+)
  end
end

digital_sums = (1..99).each_with_object([]) do |a, result|
  (1..99).each do |b|
    result << (a**b).digital_sum
  end
end

answer = digital_sums.max

puts answer
