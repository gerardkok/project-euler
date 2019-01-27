def next_collatz_number(number)
  number.even? ? number / 2 : 3 * number + 1
end

collatz_lengths = Hash.new { |h, key| h[key] = h[next_collatz_number(key)] + 1 }.update(1 => 1)

answer = (1...1_000_000).max_by { |n| collatz_lengths[n] }

puts answer
