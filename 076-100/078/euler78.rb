def pentagonal(k)
  k * (3 * k - 1) / 2
end

# https://en.wikipedia.org/wiki/Pentagonal_number_theorem
def partition_number(n, partition_numbers_so_far)
  1.step.lazy.flat_map { |k| [k, -k] }.reduce(0) do |result, k|
    pentagonal_number = pentagonal(k)
    break result if n < pentagonal_number

    sign = k.odd? ? 1 : -1
    # avoid big integers by using mod here instead of during the find
    (result + sign * partition_numbers_so_far[n - pentagonal_number]) % 1_000_000
  end
end

partition_numbers = Hash.new { |h, n| h[n] = partition_number(n, h) }.update(0 => 1)

answer = 0.step.find { |n| partition_numbers[n].zero? }

puts answer
