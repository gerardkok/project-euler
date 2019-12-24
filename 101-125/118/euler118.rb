require 'prime'

class Array
  def to_number
    reduce { |number, digit| number * 10 + digit }
  end
end

class Partition
  include Enumerable

  def initialize(array_to_partition)
    @array_to_partition = array_to_partition
  end

  def each
    if @array_to_partition.empty?
      yield []
    else
      (0...@array_to_partition.length).each do |i|
        head = @array_to_partition[0..i].to_number
        next unless head.prime?

        tail = @array_to_partition[i + 1..-1]
        Partition.new(tail).each do |t|
          yield [head] + t if t.empty? || head < t.first
        end
      end
    end
  end
end

class PandigitalPrimeSet
  include Enumerable

  def each
    (1..9).to_a.permutation.each do |p|
      Partition.new(p).each { |q| yield q }
    end
  end
end

answer = PandigitalPrimeSet.new.count

puts answer
