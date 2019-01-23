require 'prime'

LENGTH = 8
START_DIGITS = (0..10 - LENGTH).to_a.freeze

class Array
  def to_number
    reduce { |number, digit| number * 10 + digit }
  end

  def start_with_zero?
    first.zero?
  end
end

class Integer
  def digits
    to_s.chars.map(&:to_i)
  end
end

def masks(length)
  (3...length).step(3).flat_map do |n|
    (0...length).to_a.combination(n).to_a
  end
end

MASKS = Hash.new { |h, key| h[key] = masks(key) }

def maskable?(digits, mask)
  masked_digits = digits.values_at(*mask).uniq
  masked_digits.length == 1 && (START_DIGITS & masked_digits).any?
end

def prime_family?(digits, mask)
  (0..9).map { |d| replace(digits, mask, d) }.reject(&:start_with_zero?).map(&:to_number).count(&:prime?) == LENGTH
end

def replace(digits, mask, digit)
  mask.each_with_object(digits.dup) { |index, result| result[index] = digit }
end

def min_prime_of_family?(digits)
  MASKS[digits.length].select { |m| maskable?(digits, m) }.any? { |m| prime_family?(digits, m) }
end

answer = Prime.each.lazy.map(&:digits).find { |p| min_prime_of_family?(p) }.to_number

puts answer
