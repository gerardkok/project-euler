def count_summations(upto)
  initial = Array.new(upto + 1) { |i| i.zero? ? 1 : 0 }
  ways = (1...upto).each_with_object(initial) do |n, result|
    (n..upto).each do |i|
      result[i] += result[i - n]
    end
  end
  ways[upto]
end

answer = count_summations(100)

puts answer
