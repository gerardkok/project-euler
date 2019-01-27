def choose(n, k)
  (n - k + 1..n).reduce(:*) / (1..k).reduce(:*)
end

def choose_up_to(n)
  (1..n).map { |k| choose(n, k) }
end

answer = (1..100).flat_map { |n| choose_up_to(n) }.select{ |n| n > 1_000_000 }.length

puts answer
