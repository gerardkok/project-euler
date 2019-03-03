DICE_SIZE = 6
consecutive_doubles = 0
initial = Array.new(2 * DICE_SIZE, 0)
RUNS = DICE_SIZE**10
freqs = RUNS.times.each_with_object(initial) do |_, result|
  die1 = rand(DICE_SIZE).next
  die2 = rand(DICE_SIZE).next
  consecutive_doubles = (die1 == die2) ? consecutive_doubles + 1 : 0
  if consecutive_doubles == 3
    consecutive_doubles = 0
    result[0] += 1
  else
    index = die1 + die2 - 1
    result[index] += 1
  end
end

THREE_DOUBLES_PROBABILITY = (DICE_SIZE.to_f - 1) / DICE_SIZE**4 # 3 * DICE_SIZE / DICE_SIZE**5

probabilities = [THREE_DOUBLES_PROBABILITY] + (2..2 * DICE_SIZE).map { |i| DICE_SIZE - (i - DICE_SIZE - 1).abs }.map { |i| i.odd? ? (DICE_SIZE.to_f**3 * i - (DICE_SIZE - 1)) : DICE_SIZE.to_f**3 * i }.map { |i| i / (DICE_SIZE**5) }

freqs.each_with_index do |f, i|
  name = i.zero? ? 'jail' : (i + 1).to_s
  p = f.to_f / RUNS
  c = probabilities[i]
  puts "[#{name}]: #{f}, #{p}, #{c}"
end
