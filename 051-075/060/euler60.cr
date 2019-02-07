GOAL_CLIQUE_SIZE = 5

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

neighbour_cliques = Hash(Int32, Array(Set(Int32))).new do |h, prime|
  neighbours = h.keys.select { |p| (p == 3) || (p % 3 == prime % 3) }.select { |p| concatable_primes?(prime, p) }
  n = Set(Int32).new
  h[prime] = neighbours.reduce([Set(Int32).new]) do |result, p|
    neighbour_cliques_via_p = n.empty? ? [[p].to_set] : h[p].select { |clique| clique.subset?(n) }.map { |clique| clique | [p].to_set }
    n |= [p].to_set
    result.concat(neighbour_cliques_via_p)
  end
end

answer = Prime.new.each do |p|
  next if [2, 5].includes?(p)

  goal_clique = neighbour_cliques[p].find { |clique| clique.size == GOAL_CLIQUE_SIZE - 1 }
  break goal_clique.sum(p) if goal_clique
end

puts answer
