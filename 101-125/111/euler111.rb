require 'prime'

LENGTH = 10

class Array
  def to_number
    reduce { |number, digit| number * 10 + digit }
  end

  def start_with_zero?
    first.zero?
  end
end

def contribution(n)
  number = n.to_number
  number.prime? ? number : 0
end

def repeat_digit_prime_sum(repeat_digit, number_of_non_repeat_digits, from_index = 0, number = Array.new(LENGTH, repeat_digit))
  return 0 if from_index.positive? && number.start_with_zero?

  return contribution(number) if number_of_non_repeat_digits.zero?

  (from_index...LENGTH).reduce(0) do |sum, i|
    s = (0..9).reduce(0) do |acc, d|
      number[i] = d
      acc + repeat_digit_prime_sum(repeat_digit, number_of_non_repeat_digits - 1, from_index + 1, number)
    end
    number[i] = repeat_digit
    sum + s
  end
end

answer = (0..9).reduce(0) do |acc, d|
  acc + (1..LENGTH - 1).lazy.map { |i| repeat_digit_prime_sum(d, i) }.find(&:positive?)
end

puts answer
