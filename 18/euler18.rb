maxima = []
File.readlines('input18.txt').reverse_each do |line|
  line.split.map(&:to_i).each_with_index do |value, index|
    left = maxima.fetch(index, 0)
    right = maxima.fetch(index + 1, 0)
    maxima[index] = value + [left, right].max
  end
end

answer = maxima.first

puts answer
