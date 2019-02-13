def e_continued_fraction(index)
  d, m = index.divmod(3)
  m.zero? ? d * 2 : 1
end

numerators = Hash.new { |h, i| h[i] = e_continued_fraction(i) * h[i - 1] + h[i - 2] }.update(1 => 2, 2 => 3)

answer = numerators[100].to_s.chars.map(&:to_i).reduce(:+)

puts answer
