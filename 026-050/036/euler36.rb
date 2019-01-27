def palindrome?(string)
  string == string.reverse
end

palindromes = (1..1_000_000).select do |n|
  palindrome?(n.to_s) && palindrome?(n.to_s(2))
end

answer = palindromes.reduce(:+)

puts answer
