require 'prime'

def rotations(n)
  digits = n.to_s.chars.map(&:to_i)
  rotations = digits.length.times.reduce([]) do |memo, count|
    memo << digits.rotate(count)
  end
  rotations.map { |r| to_number(r) }
end

def to_number(digits)
  digits.reduce { |number, digit| number * 10 + digit }
end

def circular_prime?(n)
  rotations(n).all?(&:prime?)
end

circular_primes = Prime.each(1_000_000).select do |n|
  circular_prime?(n)
end

answer = circular_primes.length

puts answer
