class PriorityQueue
  def initialize
    @elements = [nil]
  end

  def push(number, base)
    @elements << [number, base]
    float
  end

  def length
    @elements.size - 1
  end

  def empty?
    length.zero?
  end

  def pop
    swap(1, length)
    e = @elements.pop
    sink
    e
  end

  private

  def float
    k = length
    while (j = k >> 1).positive? && @elements[j].first > @elements[k].first
      swap(j, k)
      k = j
    end
  end

  def sink
    k = 1
    while (j = 2 * k) <= length
      j += 1 if j < length && @elements[j].first > @elements[j + 1].first
      return if @elements[k].first < @elements[j].first

      swap(k, j)
      k = j
    end
  end

  def swap(i, j)
    @elements[i], @elements[j] = @elements[j], @elements[i]
  end
end

def digit_sum(n)
  result = 0
  while n.positive?
    n, digit = n.divmod(10)
    result += digit
  end
  result
end

def max_digit_sum(n)
  9 * Math.log10(n).floor + 9
end

class InterestingNumber
  include Enumerable

  GAPS = [1, 1, 6, 0, 3, 6, 0, 3, 2].freeze

  def initialize
    @queue = PriorityQueue.new
    @next_base = 2
  end

  def each
    loop do
      n = next_power(@next_base)
      @queue.push(n, @next_base) if n
      @next_base += 1

      number, base = @queue.pop
      yield number if digit_sum(number) == base

      gap = GAPS[base % 9]
      number *= base**gap
      @queue.push(number, base)
    end
  end

  private

  def next_power(base)
    gap = GAPS[base % 9]
    return nil if gap.zero?

    factor = base**gap

    result = base
    loop do
      result *= factor
      break result if max_digit_sum(result) >= base
    end
  end
end

answer = InterestingNumber.new.first(30).last

puts answer
