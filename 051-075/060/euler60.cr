CLIQUE_SIZE = 5

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

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def concatable_primes?(prime1, prime2)
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

def neighbours(prime)
  Prime.new.take_while { |p| p < prime }.select { |p| p % 3 == prime % 3 }.select { |p| concatable_primes?(prime, p) }.to_set
end

def cliques(prime, cliques)
  neighbours = neighbours(prime)
  cliques.select { |clique| clique.subset?(neighbours) }.map { |clique| clique | [prime].to_set }
end

answer = Prime.new.first(10_000).reduce([[([] of Int32).to_set], [([] of Int32).to_set]]) do |(rest_one, rest_two), p|
  rest_one_cliques = (p % 3 != 2) ? cliques(p, rest_one) : [] of Set(Int32) # ensure prime '3' will be part of both cliques
  rest_two_cliques = (p % 3 != 1) ? cliques(p, rest_two) : [] of Set(Int32)
  goal_clique = rest_one_cliques.find { |c| c.size == CLIQUE_SIZE } || rest_two_cliques.find { |c| c.size == CLIQUE_SIZE }
  break goal_clique.sum if goal_clique

  [rest_one + rest_one_cliques, rest_two + rest_two_cliques]
end

puts answer
