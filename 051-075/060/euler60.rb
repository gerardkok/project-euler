require 'prime'
require 'set'

GOAL_CLIQUE_SIZE = 5

def witnesses(n, g)
  # see https://en.wikipedia.org/wiki/Miller%E2%80%93Rabin_primality_test, 'Testing against small sets of bases'
  if n < 2_047
    [2]
  elsif n < 1_373_653
    [2, 3]
  elsif n < 9_080_191
    [31, 73]
  elsif n < 25_326_001
    [2, 3, 5]
  elsif n < 3_215_031_751
    [2, 3, 5, 7]
  else
    Array.new(g) { 2 + rand(n - 4) }
  end
end

def mod_exp(n, e, mod)
  prod = 1
  base = n % mod
  until e.zero?
    prod = (prod * base) % mod if e.odd?
    e >>= 1
    base = (base * base) % mod
  end
  prod
end

def miller_rabin_prime?(n, g = 10)
  d = n - 1
  s = 0
  while d.even?
    d >>= 1
    s += 1
  end
  witnesses(n, g).each do |a|
    x = mod_exp(a, d, n)
    next if [1, n - 1].include?(x)

    (s - 1).times do
      x = mod_exp(x, 2, n)
      return false if x == 1
      break if x == n - 1
    end
    return false if x != n - 1
  end
  true
end

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def concatable_primes?(prime1, prime2)
  miller_rabin_prime?(concat(prime1, prime2)) && miller_rabin_prime?(concat(prime2, prime1))
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
