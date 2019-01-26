DIVISORS = [2, 3, 5, 7, 11, 13, 17]

def to_number(digits) : Int64
  digits.reduce(0_i64) { |n, d| n * 10 + d }
end

def substring_div?(digits)
  digits[1..-1].each_cons(3).with_index.all? do |substring, i|
    (to_number(substring) % DIVISORS[i]).zero?
  end
end

answer = (0..9).to_a.permutations.select { |p| substring_div?(p) }.map { |p| to_number(p) }.sum

puts answer
