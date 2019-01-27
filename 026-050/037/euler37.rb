require 'prime'

class Integer
  def truncatable_prime?
    # assume self is prime, so it's not necessary to add it to its trunks
    str = to_s
    trunks = str.length.times.flat_map { |i| [str[0..i], str[i..-1]] }.map(&:to_i)
    trunks.all?(&:prime?)
  end
end

truncatable_primes = Prime.each.lazy.reject { |n| n < 10 }.select(&:truncatable_prime?).each_with_object([]) do |n, result|
  result << n
  break result if result.length == 11
end

answer = truncatable_primes.reduce(:+)

puts answer
