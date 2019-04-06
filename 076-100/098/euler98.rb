words = File.read('input98.txt').split(',').map { |n| n.delete('"') }

anagrams = words.each_with_object({}) { |word, memo| (memo[word.chars.sort.join] ||= []) << word }.select { |_, words| words.length > 1 }

puts anagrams.to_s

lengths = anagrams.keys.map(&:length)

max_square = Math.sqrt(10**lengths.max).to_i

puts max_square

#SQUARES = 1.step.lazy.map { |n| n * n }.take_while { |n| n < 10**lengths.max }.to_a.reject { |n| n < 10**(lengths.min - 1) }.freeze
squares = (1..max_square).map { |n| n * n }.reject { |n| n < 10**(lengths.min - 1) }.freeze

square_anagrams = squares.each_with_object({}) { |square, memo| (memo[square.to_s.chars.sort.join] ||= []) << square }.select { |_, squares| squares.length > 1 }

#puts square_anagrams.to_s


def map(word, mapping)
  mapping.values_at(*word.chars)
end

def map_to_i(word, mapping)
  map(word, mapping).map(&:to_i).reduce { |number, digit| number * 10 + digit }
end

def maps?(word, square, mapping)
  map(word, mapping).join == square.to_s
end

def mapping(word, square)
  return nil unless word.length == square.to_s.length

  unique_chars = word.chars.uniq
  unique_digits = square.to_s.chars.uniq
  return nil unless unique_chars.length == unique_digits.length

  mapping = unique_chars.zip(unique_digits).to_h
  maps?(word, square, mapping) ? mapping : nil
end

def word_mappings(word, squares)
  r = squares.map { |s| mapping(word, s) }.compact
#  puts "word_mappings(#{word}, #{squares}): #{r}"
  r
end

def words_mappings(words, squares)
  r = words.map { |word| word_mappings(word, squares) }.reduce(:&)
#  puts "words_mappings(#{words}, #{squares}): #{r.to_a}"
  r
end

def anagramic_squares(words, square_anagrams)
  mappings = square_anagrams.values.flat_map { |squares| words_mappings(words, squares) }.select { |m| m.any? }
  puts "anagramic_squares(#{words}, square_anagrams): mappings: #{mappings}"
  mappings.flat_map { |m| words.map { |w| map_to_i(w, m) } }
end

anagramic_squares = anagrams.flat_map { |_, words| anagramic_squares(words, square_anagrams) }

puts anagramic_squares.to_s

answer = anagramic_squares.max

puts answer
