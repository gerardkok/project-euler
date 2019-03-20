def next_squared_digit_number(number)
  result = 0
  while number.positive?
    result += (number % 10) * (number % 10)
    number /= 10
  end
  result
end

def square_digit_chain_to_89?(number)
  return number == 89 if [0, 1, 89].include?(number)

  square_digit_chain_to_89?(next_squared_digit_number(number))
end

def ascending_combinations(digits = [])
  return [[]] if digits.empty?

  head, *tail = digits
  higher_combinations = (head < 9) ? ascending_combinations([head + 1] * digits.length) : []
  ascending_combinations(tail).map { |a| [head] + a } + higher_combinations
end

def to_number(digits)
  digits.reduce { |number, digit| number * 10 + digit }
end

def factorial(n)
  (1..n).reduce(:*) || 1
end

def multinomial_coefficient(digits)
  digit_frequencies = digits.each_with_object(Array.new(10, 0)) { |d, acc| acc[d] += 1 }
  digit_frequencies.reduce(factorial(digits.length)) { |acc, d| acc / factorial(d) }
end

answer = ascending_combinations([0] * 7).select { |c| square_digit_chain_to_89?(to_number(c)) }.map { |c| multinomial_coefficient(c) }.reduce(:+)

puts answer
