KEY_LENGTH = 3
SPACE = ' '.ord

ciphertext = File.read('input59.txt').split(',').map(&:to_i)

freqs = ciphertext.each_slice(KEY_LENGTH).each_with_object(Array.new(KEY_LENGTH) { {} }) do |slice, result|
  slice.each_with_index do |letter, index|
    result[index][letter] = (result[index][letter] ||= 0) + 1
  end
end

key = freqs.map do |s|
  # ' ' is the most common character in English
  c = s.max_by { |_, f| f }.first
  c ^ SPACE
end

def decrypt(ciphertext, key)
  ciphertext.zip(key.cycle).map { |c, k| c ^ k }
end

text = decrypt(ciphertext, key)

answer = text.reduce(:+)

puts answer
