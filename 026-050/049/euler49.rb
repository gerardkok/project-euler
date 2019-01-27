require 'prime'

class Integer
  def permutation
    to_s.chars.permutation.map(&:join).map(&:to_i).uniq
  end
end

def prime_permutations(number)
  number.permutation.select { |p| p > number }.select(&:prime?).sort
end

def answer
  Prime.take_while { |p| p < 10_000 }.drop_while { |p| p < 1_000 }.each do |start_prime|
    next if start_prime == 1487 # skip solution already given in problem description

    prime_permutations(start_prime).combination(2).each do |mid_prime, end_prime|
      return "#{start_prime}#{mid_prime}#{end_prime}" if end_prime + start_prime == 2 * mid_prime
    end
  end
end

puts answer
