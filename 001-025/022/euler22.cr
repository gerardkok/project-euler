class String
  LETTER_VALUES = Hash(Char, Int32).zip(('A'..'Z').to_a, (1..26).to_a)

  def value
    chars.map { |c| LETTER_VALUES[c] }.sum
  end
end

names = File.read("input22.txt").split(',').map { |n| n.delete('"') }.sort

answer = names.map_with_index { |name, index| name.value * (index + 1) }.sum

puts answer
