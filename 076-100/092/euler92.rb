SQUARES = (0..9).map { |n| n * n }.freeze
NUMBER_OF_DIGITS = 7
MAX_SQUARED_DIGIT_SUMS = NUMBER_OF_DIGITS * 9**2 + 1

def next_squared_digit_number(number)
  result = 0
  while number.positive?
    number, modulo = number.divmod(10)
    result += SQUARES[modulo]
  end
  result
end

initial = Array.new(MAX_SQUARED_DIGIT_SUMS) { |i| i.zero? ? 1 : 0 }
numbers_ending_on = (1..NUMBER_OF_DIGITS).reduce(initial) do |acc, k|
  Array.new(MAX_SQUARED_DIGIT_SUMS) do |n|
    SQUARES.reduce(0) do |sum, square|
      add = (n >= square) ? acc[n - square] : 0
      sum + add
    end
  end
end

def square_digit_chain_to_89?(number)
  return number == 89 if [1, 89].include?(number)

  square_digit_chain_to_89?(next_squared_digit_number(number))
end

answer = (1...MAX_SQUARED_DIGIT_SUMS).reduce(0) do |acc, n|
  add = square_digit_chain_to_89?(n) ? numbers_ending_on[n] : 0
  acc + add
end

puts answer
