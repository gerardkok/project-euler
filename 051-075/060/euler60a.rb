require 'prime'
require 'set'

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def concatable_primes?(prime1, prime2)
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

def neighbours(prime, vertices)
  vertices.select { |p| (p == 3) || (p % 3 == prime % 3) }.select { |p| concatable_primes?(prime, p) }
end

cliques = Hash.new do |h, prime|
  n = [].to_set
  neighbour_cliques = neighbours(prime, h.keys).reduce([[].to_set]) do |result, p|
    n |= [p]
    cliques_p = h[p].select { |clique| clique.subset?(n) }
    result.concat(cliques_p)
  end
  h[prime] = neighbour_cliques.map { |clique| clique | [prime] }
end

Prime.each(10_000) do |p|
  next if [2, 5].include?(p)

  cliques[p].select { |clique| clique.size >= 5 }.map(&:to_a).map(&:to_s).each do |c|
    puts c
  end
end
