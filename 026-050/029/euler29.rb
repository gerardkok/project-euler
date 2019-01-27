require 'set'

def powers(number)
  (2..100).map { |b| number**b }
end

answer = (2..100).map { |a| powers(a) }.reduce([].to_set, :|).size

puts answer
