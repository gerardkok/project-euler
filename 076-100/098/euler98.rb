class Hash
  def to_digits(word)
    values_at(*word.chars)
  end

  def to_i(word)
    to_digits(word).map(&:to_i).reduce { |number, digit| number * 10 + digit }
  end

  def maps?(word, digitstring)
    to_digits(word).join == digitstring
  end
end

def mapping(word, digitstring)
  return nil unless word.length == digitstring.length

  unique_chars = word.chars.uniq
  unique_digits = digitstring.chars.uniq
  return nil unless unique_chars.length == unique_digits.length

  mapping = unique_chars.zip(unique_digits).to_h
  mapping.maps?(word, digitstring) ? mapping : nil
end

def word_mappings(word, digitstrings)
  digitstrings.map { |s| mapping(word, s) }.compact
end

def anagramic_squares(words, square_anagrams)
  mappings = square_anagrams.flat_map { |sqs| words.map { |word| word_mappings(word, sqs) }.reduce(:&) }
  mappings.flat_map { |m| words.map { |word| m.to_i(word) } }
end

words = File.read('input98.txt').split(',').map { |n| n.delete('"') }

anagrams = words.each_with_object({}) { |word, memo| (memo[word.chars.sort.join] ||= []) << word }.values.select { |l| l.length > 1 }

max_length = anagrams.map(&:first).map(&:length).max

max_square = Math.sqrt(10**max_length)

squares = (1..max_square).map { |n| n * n }.map(&:to_s)

square_anagrams = squares.each_with_object({}) { |square, memo| (memo[square.chars.sort.join] ||= []) << square }.values.select { |s| s.length > 1 }

anagramic_squares = anagrams.flat_map { |anagram| anagramic_squares(anagram, square_anagrams) }

answer = anagramic_squares.max

puts answer
