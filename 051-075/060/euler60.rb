require 'prime'
require 'set'

GOAL_CLIQUE_SIZE = 5

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def concatable_primes?(prime1, prime2)
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

neighbour_cliques = Hash.new do |h, prime|
  neighbours = h.keys.select { |p| (p == 3) || (p % 3 == prime % 3) }.select { |p| concatable_primes?(prime, p) }.to_set
  h[prime] = neighbours.reduce([Set.new]) do |result, p|
    neighbour_cliques_via_p = h[p].select { |clique| clique.subset?(neighbours) }.map { |clique| clique | [p] }
    result.concat(neighbour_cliques_via_p)
  end
end

answer = Prime.each do |p|
  next if [2, 5].include?(p)

  goal_clique = neighbour_cliques[p].find { |clique| clique.size == GOAL_CLIQUE_SIZE - 1 }
  break goal_clique.reduce(p, :+) if goal_clique
end

puts answer
