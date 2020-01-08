TURNS = 15

initial = Array.new(TURNS + 1)  { |i| i.zero? ? 1 : 0 }

ways = (1..TURNS).each_with_object(initial) do |i, memo|
  i.downto(1) do |j|
    memo[j] += memo[j - 1] * i
  end
end

def factorial(n)
  (1..n).reduce(:*) || 1
end

max_index_blue_wins = (TURNS - 1) / 2
count_blue_wins = ways[0..max_index_blue_wins].reduce(:+)
count_total = factorial(TURNS + 1)

answer = count_total / count_blue_wins

puts answer
