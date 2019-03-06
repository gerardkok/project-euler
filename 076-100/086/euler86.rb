class Integer
  def square?
    (Math.sqrt(self) % 1).zero?
  end
end

def count_shortest_paths(l)
  (1..l).reduce(0) do |memo, b_plus_h|
    # l is short side
    short_count = (l**2 + b_plus_h**2).square? ? b_plus_h / 2 : 0

    # l is long side
    long_count = (l**2 + (l + b_plus_h)**2).square? ? 1 + (l - (l + b_plus_h + 1) / 2) : 0

    memo + short_count + long_count
  end
end

cuboid_shortests_paths = Hash.new { |h, k| h[k] = h[k - 1] + count_shortest_paths(k) }.update(1 => 0)

answer = 1.step.find { |n| cuboid_shortests_paths[n] > 1_000_000 }

puts answer
