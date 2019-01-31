require 'prime'
require 'set'

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def concatable_primes?(prime1, prime2)
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

def neighbours(prime)
  Prime.each(prime).select { |p| concatable_primes?(prime, p) }.to_set
end

cliques = Prime.each(10_000).reduce([[].to_set]) do |result, p|
  n = neighbours(p)
  c = result.select { |clique| clique.subset?(n) }.map { |clique| clique + [p] }
  result + c
end

#puts "cliques found: #{cliques}"

max = cliques.max_by(&:length).to_a

puts "max: #{max}"
