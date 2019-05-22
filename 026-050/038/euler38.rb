def pandigital?(string)
  string.chars.sort.join == '123456789'
end

# suppose the pandigial product 'p' is constructed by concatenating factors 'f1'...'fn' with n > 1
# we can limit the search space as follows:
# - p starts with a 9, because the example in the problem description starts with a 9, and p is greater than the example
# - f1 has at most 4 digits; if it has 5, then f2 would have at least 5 too, and p would have at least 10
# - f1 cannot have 1 digit, because in that case p would be the example from the problem description
# - f1 cannot have 2 digits, because in that case p would have 8 digits if n = 3, and 11 if n = 4, which doesn't fit
# - f1 cannot have 3 digits, because in that case p would have 7 digits if n = 2, and 10 if n = 3, which doesn't fit
# - so f1 has 4 digits, and n = 2
# - furthermore, then second digit of p cannot be 5 or higher, because then f2 would start with 19, causing '9' to be a duplicate digit
# - none of f1's digits can be 1, because the first digit of f2 is a 1
# all in all, p lies between 9234 and 9487
answer = 9487.downto(9234) do |i|
  result = i.to_s.concat((2 * i).to_s)
  break result if pandigital?(result)
end

puts answer
