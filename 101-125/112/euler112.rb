class Integer
  def digits
    to_s.chars.map(&:to_i)
  end

  def increasing?
    digits.each_cons(2).all? { |x, y| x <= y }
  end

  def decreasing?
    digits.each_cons(2).all? { |x, y| x >= y }
  end

  def bouncy?
    !increasing? && !decreasing?
  end
end

bouncy_count_upto = Hash.new { |h, number| h[number] = number.bouncy? ? h[number - 1] + 1 : h[number - 1] }.update(0 => 0)

answer = 1.step.lazy.find { |i| bouncy_count_upto[i] * 100 == 99 * i }

puts answer
