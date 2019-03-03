require 'matrix'

DICE_SIZE = 6
SQUARES = [:GO, :A1, :CC1, :A2, :T1, :R1, :B1, :CH1, :B2, :B3,
           :JAIL, :C1, :U1, :C2, :C3, :R2, :D1, :CC2, :D2, :D3,
           :FP, :E1, :CH2, :E2, :E3, :R3, :F1, :F2, :U2, :F3,
           :G2J, :G1, :G2, :CC3, :G3, :R4, :CH3, :H1, :T2, :H2].freeze

THREE_DOUBLES_PROBABILITY = (DICE_SIZE.to_f - 1) / DICE_SIZE**4

DICE_PROBABILITY = (2..2 * DICE_SIZE).map { |i| DICE_SIZE - (i - DICE_SIZE - 1).abs }.map { |i| i.odd? ? (DICE_SIZE.to_f**3 * i - (DICE_SIZE - 1)) : DICE_SIZE.to_f**3 * i }.map { |i| i / (DICE_SIZE**5) }

# THREE_DOUBLES_PROBABILITY = 1.0 / DICE_SIZE**3
# NOT_THREE_DOUBLES_PROBABILITY = 1.0 - THREE_DOUBLES_PROBABILITY

# DICE_PROBABILITY = (2..2*DICE_SIZE).map { |i| DICE_SIZE - (i - DICE_SIZE - 1.0).abs }.map { |i| i * NOT_THREE_DOUBLES_PROBABILITY / DICE_SIZE**2 }
#DICE_PROBABILITY = (2..2*DICE_SIZE).map { |i| DICE_SIZE - (i - DICE_SIZE - 1.0).abs }.map { |i| i / DICE_SIZE**2 }

sdp = DICE_PROBABILITY.reduce(:+)  + THREE_DOUBLES_PROBABILITY

puts "sum dice probabilities: #{sdp}"

def next_railway(chance_square)
  case chance_square
  when :CH1 then :R2
  when :CH2 then :R3
  else :R1
  end
end

def next_utility(community_chest_square)
  (community_chest_square == :CH2) ? :U2 : :U1
end

def community_chest?(square)
  [:CC1, :CC2, :CC3].include?(square)
end

def chance?(square)
  [:CH1, :CH2, :CH3].include?(square)
end

roll_matrix_rows = Array.new(SQUARES.length) { Array.new(SQUARES.length, 0.0) }

(0...SQUARES.length).each do |column|
  DICE_PROBABILITY.each_with_index do |d, i|
    row = (column + i + 2) % SQUARES.length
    roll_matrix_rows[row][column] = d
  end
  roll_matrix_rows[SQUARES.index(:JAIL)][column] += THREE_DOUBLES_PROBABILITY
end

roll_matrix = Matrix[*roll_matrix_rows]

special_transition_matrix_rows = Array.new(SQUARES.length) { Array.new(SQUARES.length, 0.0) }

(0...SQUARES.length).each do |column|
  if SQUARES[column] == :G2J
    special_transition_matrix_rows[SQUARES.index(:JAIL)][column] = 1.0
  elsif chance?(SQUARES[column])
    [:GO, :JAIL, :C1, :E3, :H2, :R1].each do |card|
      special_transition_matrix_rows[SQUARES.index(card)][column] = 1.0 / 16
    end
    three_squares_back = (column - 3) % SQUARES.length
    # if community_chest?(SQUARES[three_squares_back])
    #   special_transition_matrix_rows[three_squares_back][column] += (1.0 / 16) * (14.0 / 16)
    #   [:GO, :JAIL].each do |card|
    #     special_transition_matrix_rows[SQUARES.index(card)][column] += (1.0 / 16) * (1.0 / 16)
    #   end
    # else
      special_transition_matrix_rows[three_squares_back][column] = 1.0 / 16
    # end
    special_transition_matrix_rows[SQUARES.index(next_railway(column))][column] += (1.0 / 16)
    special_transition_matrix_rows[SQUARES.index(next_utility(column))][column] += (1.0 / 16)
    special_transition_matrix_rows[column][column] = 7.0 / 16
  elsif community_chest?(SQUARES[column])
    [:GO, :JAIL].each do |card|
      special_transition_matrix_rows[SQUARES.index(card)][column] += (1.0 / 16)
    end
    special_transition_matrix_rows[column][column] = 14.0 / 16
  else
    special_transition_matrix_rows[column][column] = 1.0
  end
end

special_transition_matrix = Matrix[*special_transition_matrix_rows]

transition_matrix = special_transition_matrix * roll_matrix

transition_matrix.column_vectors().map { |r| r.reduce(:+) }.each_with_index do |s, i|
  puts "[#{i}]: #{s}"
end

v, = transition_matrix.eigen

normalized_vector = v.column(0).map(&:abs) # v.real.column(0) # .normalize

answer = normalized_vector.each_with_index.max_by(3) { |value, _| value }.map(&:last).map { |n| '%02d' % n }.join

puts answer

puts normalized_vector.to_s

sum = normalized_vector.reduce(:+)
normalized_vector.map { |x| (x * 100 / sum).round(2) }.each_with_index do |e, i|
  puts "[#{i}]: #{e}"
end

# nv = v.real.column(0)
# sum = nv.reduce(:+)
# nnv = nv.map { |x| (x * 100 / sum).round(3) }
# puts nnv.reduce(:+)
# nnnv = nnv.each_with_index.each_with_object({}) do |(v, i), result|
#   result[i] = v
# end
# nnnv.sort_by(&:last).reverse.each do |i, v|
#   puts "[#{i}]: #{v}"
# end
