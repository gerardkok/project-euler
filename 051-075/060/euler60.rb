require 'prime'

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def concatable_primes?(prime1, prime2)
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

def concatable?(prime, set)
  set.all? { |p| concatable_primes?(p, prime) }
end

# $concatable_primes = Hash.new do |h, prime|
#   h[prime] = h.keys.each_with_object([]) do |p, memo|
#     if concatable_primes?(prime, p)
#       puts "concatable: prime: #{prime}, p:#{p}"
#       memo << [p, prime]
#       h[p].select { |s| concatable?(prime, s) }.map { |i| i << prime }.each do |i|
#         puts "prime: #{prime}, p: #{p}, h[#{p}]: #{h[p]}, i: #{i}"
#         memo << i
#       end
#     end
#   end
# end

$concatable_primes = Hash.new do |h, prime|
  c = h.keys.reduce([[]]) do |memo, p|
#    puts "considering #{p}"
    memo + h[p].select { |s| concatable?(prime, s) }
  end
#  puts "c: #{c}"
  h[prime] = c.map { |i| i + [prime] }
end

Prime.each(10_000).each do |p|
  a = $concatable_primes[p]
end

r = $concatable_primes.map { |_, s| s.max_by { |t| t.length } }.max_by(&:length)

answer = r.reduce(:+)

puts "r: #{r}, answer: #{answer}"
