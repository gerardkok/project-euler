require 'prime'
require 'set'

CLIQUE_SIZE = 5

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def concatable_primes?(prime1, prime2)
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

def neighbours(prime)
  Prime.each(prime).select { |p| p % 3 == prime % 3 }.select { |p| concatable_primes?(prime, p) }.to_set
end

def cliques(prime, cliques)
  neighbours = neighbours(prime)
  cliques.select { |clique| clique.subset?(neighbours) }.map { |clique| clique + [prime] }
end

answer = Prime.each.reduce([[[].to_set], [[].to_set]]) do |(rest_one, rest_two), p|
  rest_one_cliques = (p % 3 != 2) ? cliques(p, rest_one) : [] # ensure prime '3' will be part of both cliques
  rest_two_cliques = (p % 3 != 1) ? cliques(p, rest_two) : []
  goal_clique = rest_one_cliques.find { |c| c.size == CLIQUE_SIZE } || rest_two_cliques.find { |c| c.size == CLIQUE_SIZE }
  break goal_clique.reduce(:+) if goal_clique

  [rest_one + rest_one_cliques, rest_two + rest_two_cliques]
end

puts answer
