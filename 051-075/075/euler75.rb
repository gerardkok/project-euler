MAX_SUM = 1_500_000

def triplet_sum(m, n)
  2 * m * (m + n)
end

triplet_sum_freqs = begin
  m_n = [[2, 1]]
  triplet_sum_freqs = Hash.new(0)
  loop do
    m_n.map { |m, n| triplet_sum(m, n) }.each do |triplet_sum|
      (triplet_sum..MAX_SUM).step(triplet_sum) do |i|
        triplet_sum_freqs[i] += 1
      end
    end
    m_n = m_n.flat_map { |m, n| [[2 * m - n, m], [2 * m + n, m], [m + 2 * n, n]] }.select { |m, n| triplet_sum(m, n) <= MAX_SUM }
    break triplet_sum_freqs if m_n.empty?
  end
end

answer = triplet_sum_freqs.values.count { |l| l == 1 }

puts answer
