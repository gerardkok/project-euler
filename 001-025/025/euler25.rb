class Fibonacci
  include Enumerable

  def initialize
    @current = 0
    @next = 1
  end

  def each
    loop do
      yield @current
      @current, @next = @next, @current + @next
    end
  end
end

answer = Fibonacci.new.each_with_index.find { |f, _| f > 10**999 }.last

puts answer
