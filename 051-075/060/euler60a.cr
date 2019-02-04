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
  include Enumerable(Int64)

  def initialize
    @current_prime = 2_i64
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

def concat(number1 : Int64, number2 : Int64) : Int64
  (number1.to_s + number2.to_s).to_i64
end

def concatable_primes?(prime1 : Int64, prime2 : Int64) : Bool
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

cliques = Hash(Int64, Array(Set(Int64))).new do |h, prime|
  neighbours = h.keys.select { |p| (p == 3) || (p % 3 == prime % 3) }.select { |p| concatable_primes?(prime, p) }.to_set
  h[prime] = neighbours.reduce([[prime].to_set]) do |result, nb|
    cliques_nb = h[nb].select { |clique| clique.subset?(neighbours) }.map { |clique| clique | [prime].to_set }
    result | cliques_nb
  end
end

Prime.new.each do |p|
  next if [2_i64, 5_i64].includes?(p)

  cliques[p].select { |clique| clique.size >= 5 }.map(&.to_a).map(&.to_s).each do |c|
    puts c
  end
end
