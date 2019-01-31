require 'prime'

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def digitsum(number)
  number.to_s.chars.map(&:to_i).reduce(:+)
end

def concatable_primes?(prime1, prime2)
#  return false if ((digitsum(prime1) + digitsum(prime2)) % 3).zero?
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

def concatable?(prime, set)
  set.all? { |p| concatable_primes?(p, prime) }
end

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
#  puts "[#{p}]: #{a}"
end

r = $concatable_primes.map { |_, s| s.max_by { |t| t.length } }.max_by(&:length)

answer = r.reduce(:+)

puts "r: #{r}, answer: #{answer}"
