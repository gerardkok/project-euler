class String
  LETTER_VALUES = ('A'..'Z').zip(1..26).to_h.freeze

  def value
    LETTER_VALUES.values_at(*chars).reduce(:+)
  end
end

names = File.read('input22.txt').split(',').map { |n| n.delete('"') }.sort

answer = names.each_with_index.map { |name, index| name.value * (index + 1) }.reduce(:+)

puts answer
