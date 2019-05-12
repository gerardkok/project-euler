def pandigital?(string)
  string.chars.sort.join == '123456789'
end

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

class String
  def pandigital?
    chars.sort.join == '123456789'
  end
end

class Integer
  def pandigital_ends?
    as_string = to_s
    return false if as_string.size < 9

    as_string[-9..-1].pandigital? && as_string[0..8].pandigital?
  end

  def pandigital_tail?
    as_string = to_s
    return false if as_string.size < 9

    as_string[-9..-1].pandigital?
  end

  def pandigital_head?
    as_string = to_s
    return false if as_string.size < 9

    as_string[0..8].pandigital?
  end
end

answer = Fibonacci.new.each_with_index do |f, i|
  break i if f.pandigital_ends?
end

puts answer
