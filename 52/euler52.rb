def permutation?(one, other)
  one.to_s.chars.sort == other.to_s.chars.sort
end

def permuted_multiple?(number)
  (2..6).map { |n| number * n }.all? { |n| permutation?(number, n) }
end

answer = 12.step(by: 3).lazy.select { |n| n.to_s.start_with?('1') }.find { |n| permuted_multiple?(n) }

puts answer
