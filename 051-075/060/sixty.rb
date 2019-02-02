require 'prime'
require 'set'

def concat(number1, number2)
  (number1.to_s + number2.to_s).to_i
end

def concatable_primes?(prime1, prime2)
  concat(prime1, prime2).prime? && concat(prime2, prime1).prime?
end

def neighbours(prime)
  Prime.each(prime).select { |p| concatable_primes?(prime, p) }
end

def new_neighbourhood(neighbours, neighbouring_cliques, cliques)
#  puts "    entering new_neighbourhood(#{neighbours}, #{neighbouring_cliques}, #{cliques})"
  case neighbouring_cliques
  when []
    [[]]
  when [[]]
    neighbours.map{ |n| [n] }
  else
#    puts "    computing new neighbouring cliques"
    neighbouring_cliques.each_with_object([]) do |nc, result|
#      puts "      nc: #{nc}, last: #{nc.last}"
      neighbours.select { |n| n > nc.last }.each do |n|
#        puts "        n: #{n}"
        c = nc + [n]
#        puts "        c: #{c}"
        result << c if cliques.include?(c)
      end
    end
  end
end

def cliques_p(p, cliques)
  neighbours = neighbours(p)
  neighbouring_cliques = []
  result = []
  loop do
#    puts "  old neighbouring_cliques: #{neighbouring_cliques}"
    neighbouring_cliques = new_neighbourhood(neighbours, neighbouring_cliques, cliques)
#    puts "  new neighbouring_cliques: #{neighbouring_cliques}"
    break result if neighbouring_cliques.empty?

    new_cliques = neighbouring_cliques.map { |c| c + [p] }
#    puts "  new cliques: #{new_cliques}"
    result.concat(new_cliques)
  end
#  puts "  cliques for #{p}: #{result}"
  result
end

cliques = []
Prime.each(700) do |p|
#  puts "(#{p})"
  c = cliques_p(p, cliques)
  cliques += c
#  puts "cliques so far: #{cliques}"
  # print(c)
  # print(cliques)
end
puts "cliques: #{cliques}"
