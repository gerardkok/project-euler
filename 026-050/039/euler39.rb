MAX_M = Math.sqrt(1_000 / 2).ceil

freqs = (1..MAX_M).each_with_object({}) do |m, memo|
  (1..m).each do |n|
    next unless (m + n).odd? && m.gcd(n) == 1 # only consider primitive Pythagorean triples

    triplet_sum = 2 * m * (m + n)
    (triplet_sum..1_000).step(triplet_sum).each do |i|
      memo[i] = (memo[i] ||= 0) + 1
    end
  end
end

answer = freqs.max_by(&:last).first

puts answer
