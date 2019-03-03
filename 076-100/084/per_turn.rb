FACES = 6

def roll_probabilities(doubles = 1)
  (1..FACES).each_with_object(Hash.new(0)) do |i, acc|
    (1..FACES).each do |j|
      if i == j
        next if doubles >= 3

        extra_roll = roll_probabilities(doubles + 1)
        extra_roll.each do |c, p|
          acc[i + j + c] += p
        end
      else
        acc[i + j] += (1.0 / FACES)**(doubles * 2)
      end
    end
  end
end

probs = roll_probabilities

probs.sort.each do |c, p|
  puts "[#{c}]: #{p}"
end

THREE_DOUBLES_PROBABILITY = (1.0 / FACES)**3

sum = probs.values.reduce(:+)
total = sum + THREE_DOUBLES_PROBABILITY

puts "sum: #{sum}, #{THREE_DOUBLES_PROBABILITY}, total: #{total}"
