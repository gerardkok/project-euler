LOG_SQRT_5 = Math.log10(Math.sqrt(5))
LOG_PHI = Math.log10((1 + Math.sqrt(5)) / 2)

class FibonacciModulo
  include Enumerable

  def initialize
    @current = 0
    @next = 1
  end

  def each
    loop do
      yield @current
      @current, @next = @next, (@current + @next) % 1_000_000_000
    end
  end
end

class Integer
  def pandigital?
    to_s.chars.sort.join == '123456789'
  end
end

answer = FibonacciModulo.new.each_with_index do |tail, i|
  next unless tail.pandigital?

  f_i = i * LOG_PHI - LOG_SQRT_5
  head = (10**(f_i - f_i.to_i + 8)).to_i
  break i if head.pandigital?
end

puts answer
