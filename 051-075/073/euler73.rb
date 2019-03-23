# algorithm from https://people.csail.mit.edu/mip/papers/farey/talk.pdf
def rank(denominator, n)
  t = Array.new(n + 1) { |i| i / denominator }
  (1..n / 2).each do |i|
    (2 * i..n).step(i) do |j|
      t[j] -= t[i]
    end
  end
  t.reduce(:+)
end

answer = rank(2, 12_000) - rank(3, 12_000) - 1

puts answer
