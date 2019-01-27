def to_number(digits)
  digits.reduce { |number, digit| number * 10 + digit }
end

def product(digits)
  to_number(digits[5..8])
end

def multiplication(digits)
  [1, 2].map do |i|
    multiplicand = to_number(digits[0...i])
    multiplier = to_number(digits[i..4])
    multiplicand * multiplier
  end
end

pandigital_products = (1..9).to_a.permutation.select do |digits|
  # only possibilities are 1 digit * 4 digits = 4 digits, or 2 digits * 3 digits = 4 digits
  # so the product always starts at the 6th digit
  multiplication(digits).include?(product(digits))
end

answer = pandigital_products.map { |p| product(p) }.uniq.reduce(:+)

puts answer
