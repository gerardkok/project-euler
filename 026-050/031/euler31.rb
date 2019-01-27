COINS = [1, 2, 5, 10, 20, 50, 100, 200].freeze

class Combinations
  def self.combine(amount)
    @ways = [1]
    COINS.each do |coin|
      (coin..amount).each do |a|
        @ways[a] = (@ways[a] ||= 0) + @ways[a - coin]
      end
    end
    @ways[amount]
  end
end

answer = Combinations.combine(200)

puts answer
