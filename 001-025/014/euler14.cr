def next_collatz_number(number : Int64) : Int64
  number.even? ? number / 2 : 3_i64 * number + 1
end

collatz_lengths = Hash(Int64, Int64).new { |h, key| h[key] = key == 1_i64 ? 1_i64 : h[next_collatz_number(key)] + 1 }

answer = (1_i64...1_000_000_i64).max_by { |n| collatz_lengths[n] }

puts answer
