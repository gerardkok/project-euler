struct Int
  def palindrome?
    to_s == to_s.reverse
  end
end

palindrome_products = (100..999).reduce([] of Int32) do |memo, value|
  palindromes = (value..999).map { |i| value * i }.select(&.palindrome?)
  memo + palindromes
end

answer = palindrome_products.max

puts answer
