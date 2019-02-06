require 'prime'
require 'set'

GOAL_CLIQUE_SIZE = 5

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def concatable_primes?(prime1, prime2)
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

def neighbours(prime, vertices)
  vertices.select { |p| (p == 3) || (p % 3 == prime % 3) }.select { |p| concatable_primes?(prime, p) }
end

neighbour_cliques = Hash.new do |h, prime|
  n = Set.new
  h[prime] = neighbours(prime, h.keys).reduce([Set.new]) do |result, p|
    neighbour_cliques_via_p = h[p].select { |clique| clique.subset?(n) }.map { |clique| clique | [p] }
    n |= [p]
    result.concat(neighbour_cliques_via_p)
  end
end

answer = Prime.each do |p|
  next if [2, 5].include?(p)

  goal_clique = neighbour_cliques[p].find { |clique| clique.size == GOAL_CLIQUE_SIZE - 1 }
  break goal_clique.reduce(p, :+) if goal_clique
end

puts answer
