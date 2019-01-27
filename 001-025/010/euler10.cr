struct Int
  def prime?
    return self > 1 if self <= 3
    return false if (self % 2).zero? || (self % 3).zero?
    i = 5
    while i * i <= self
      return false if (self % i).zero? || (self % (i + 2)).zero?
      i += 6
    end
    true
  end
end

class Prime
  include Enumerable(Int32)

  def initialize
    @current_prime = 2
  end

  def each
    loop do
      yield @current_prime
      loop do
        @current_prime += 1
        break if @current_prime.prime?
      end
    end
  end
end

answer = Prime.new.take_while { |p| p < 2_000_000 }.sum(0_i64)

puts answer
