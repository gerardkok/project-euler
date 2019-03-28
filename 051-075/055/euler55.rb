class Integer
  def palindrome?
    to_s == to_s.reverse
  end

  def reverse
    to_s.reverse.to_i
  end

  def lychrel?
    n = self
    50.times do
      n += n.reverse
      return false if n.palindrome?
    end
    true
  end
end

answer = (1..10_000).select(&:lychrel?).length

puts answer
