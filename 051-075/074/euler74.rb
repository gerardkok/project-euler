def factorial(n)
  (1..n).reduce(:*) || 1
end

FACTORIALS = (0..9).map { |n| factorial(n) }.freeze

def factorial_digit_sum(n)
  n.to_s.chars.map(&:to_i).map { |d| FACTORIALS[d] }.reduce(:+)
end

cycles = {
  1 => 1,
  2 => 1,
  145 => 1,
  169 => 3,
  871 => 2,
  872 => 2,
  1454 => 3,
  40_585 => 1,
  45_361 => 2,
  45_362 => 2,
  363_601 => 3
}

factorial_chain_length = Hash.new { |h, key| h[key] = 1 + h[factorial_digit_sum(key)] }.update(cycles)

answer = (0..1_000_000).count { |n| factorial_chain_length[n] == 60 }

puts answer
