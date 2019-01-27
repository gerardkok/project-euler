answer = File.readlines('input13.txt').map(&:to_i).reduce(:+).to_s[0...10]

puts answer
