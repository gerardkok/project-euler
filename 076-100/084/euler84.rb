require 'matrix'

FACES = 4
SQUARES = [:GO, :A1, :CC1, :A2, :T1, :R1, :B1, :CH1, :B2, :B3,
           :JAIL, :C1, :U1, :C2, :C3, :R2, :D1, :CC2, :D2, :D3,
           :FP, :E1, :CH2, :E2, :E3, :R3, :F1, :F2, :U2, :F3,
           :G2J, :G1, :G2, :CC3, :G3, :R4, :CH3, :H1, :T2, :H2].freeze

THREE_DOUBLES_PROBABILITY = (FACES.to_f - 1) / FACES**4

roll_probabilities = (1..FACES).each_with_object({}) do |i, acc|
  p = (i.odd? ? (FACES.to_f**3 * i - (FACES - 1)) : FACES.to_f**3 * i) / FACES**5
  [i, 2 * FACES - i].uniq.map(&:next).each do |k|
    acc[k] = p
  end
end

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
  roll_probabilities.each do |roll, p|
    row = (column + roll) % SQUARES.length
    roll_matrix_rows[row][column] = p
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
    three_squares_back = (column - 3) # % SQUARES.length
    if community_chest?(SQUARES[three_squares_back])
      special_transition_matrix_rows[three_squares_back][column] += (1.0 / 16) * (14.0 / 16)
      [:GO, :JAIL].each do |card|
        special_transition_matrix_rows[SQUARES.index(card)][column] += (1.0 / 16) * (1.0 / 16)
      end
    else
      special_transition_matrix_rows[three_squares_back][column] += 1.0 / 16
    end
    special_transition_matrix_rows[SQUARES.index(next_railway(column))][column] = (1.0 / 16)
    special_transition_matrix_rows[SQUARES.index(next_utility(column))][column] = (1.0 / 16)
    special_transition_matrix_rows[column][column] = 7.0 / 16
  elsif community_chest?(SQUARES[column])
    [:GO, :JAIL].each do |card|
      special_transition_matrix_rows[SQUARES.index(card)][column] = (1.0 / 16)
    end
    special_transition_matrix_rows[column][column] = 14.0 / 16
  else
    special_transition_matrix_rows[column][column] = 1.0
  end
end

special_transition_matrix = Matrix[*special_transition_matrix_rows]

transition_matrix = special_transition_matrix * roll_matrix

v, = transition_matrix.eigen

dominant_vector = v.column(0)
sum = dominant_vector.reduce(:+)
normalized_vector = dominant_vector.map { |x| x / sum }

answer = normalized_vector.each_with_index.max_by(3, &:first).map(&:last).map { |n| '%02d' % n }.join

puts answer
