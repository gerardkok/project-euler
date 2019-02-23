COINS = [1, 2, 5, 10, 20, 50, 100, 200].freeze

def combine(amount)
  initial = Array.new(amount + 1) { |i| i.zero? ? 1 : 0 }
  ways = COINS.each_with_object(initial) do |coin, result|
    (coin..amount).each do |a|
      result[a] += result[a - coin]
    end
  end
  ways[amount]
end

answer = combine(200)

puts answer
