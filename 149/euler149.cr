SIZE = 2000

first55 = (1..55).map { |k| ((100_003_i64 - 200_003_i64 * k + 300_007_i64 * k**3) % 1_000_000).to_i - 500_000 }
s = (0...SIZE * SIZE).each_with_object(Array.new(SIZE * SIZE, 0)) do |k, acc|
  acc[k] = (k < 55) ? first55[k] : (acc[k - 24] + acc[k - 55] + 1_000_000) % 1_000_000 - 500_000
end

max_subarray_sums = begin
  initial = Array.new(6 * SIZE - 2, -500_000)
  (0...SIZE).each_with_object(initial) do |row, max_ending_here|
    (0...SIZE).each do |column|
      term_s = s[SIZE * row + column]
      # max_ending_here horizontal, diagonal, antidiagonal, vertical
      [row, column + row + SIZE, -1 - column - (row + SIZE), -1 - column].each do |subarray_index|
        max_ending_here[subarray_index] = max_ending_here[subarray_index] < 0 ? term_s : term_s + max_ending_here[subarray_index]
      end
    end
  end
end

answer = max_subarray_sums.max

puts answer
