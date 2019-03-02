require 'matrix'

DICE_SIZE = 4
SQUARES = [:GO, :A1, :CC1, :A2, :T1, :R1, :B1, :CH1, :B2, :B3,
  :JAIL, :C1, :U1, :C2, :C3, :R2, :D1, :CC2, :D2, :D3,
  :FP, :E1, :CH2, :E2, :E3, :R3, :F1, :F2, :U2, :F3,
  :G2J, :G1, :G2, :CC3, :G3, :R4, :CH3, :H1, :T2, :H2].freeze

THREE_DOUBLES_PROBABILITY = Rational(1, DICE_SIZE)**3
NOT_THREE_DOUBLES_PROBABILITY = 1 - THREE_DOUBLES_PROBABILITY

DICE_PROBABILITY = (2..2*DICE_SIZE).map { |i| DICE_SIZE - (i - DICE_SIZE - 1.0).abs }.map { |i| i * NOT_THREE_DOUBLES_PROBABILITY / DICE_SIZE**2 }

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

def square_probability(row, square, dice_probablity)
#  puts "square_probability(#{row}, square, dice_probablity)"
  case SQUARES[square]
  when :G2J
    row[SQUARES.index(:JAIL)] += dice_probablity
  when :CC1, :CC2, :CC3
    row[SQUARES.index(:GO)] += dice_probablity / 16
    row[SQUARES.index(:JAIL)] += dice_probablity / 16
    row[square] += 14 * dice_probablity / 16
  when :CH1, :CH2, :CH3
    row[SQUARES.index(:GO)] += dice_probablity / 16
    row[SQUARES.index(:JAIL)] += dice_probablity / 16
    row[SQUARES.index(:C1)] += dice_probablity / 16
    row[SQUARES.index(:E3)] += dice_probablity / 16
    row[SQUARES.index(:H2)] += dice_probablity / 16
    row[SQUARES.index(:R1)] += dice_probablity / 16
    row[SQUARES.index(next_railway(SQUARES[square]))] += 2 * dice_probablity / 16
    row[SQUARES.index(next_utility(SQUARES[square]))] += dice_probablity / 16
    y = (square < 3) ? square + 37 : square - 3
    square_probability(row, y, dice_probablity)
    row[square] += 6 * dice_probablity / 16
  else
    row[square] += dice_probablity
  end
end

def row_probabilities(row_index)
  row = Array.new(SQUARES.length, 0)
  row[SQUARES.index(:JAIL)] += THREE_DOUBLES_PROBABILITY

  DICE_PROBABILITY.each_with_index do |d, i|
    square = (row_index + i + 2) % SQUARES.length
    square_probability(row, square, d)
  end
#  puts "row: #{row}"
  row
end

rows = (0...SQUARES.length).reduce([]) do |rows, r|
  rows << row_probabilities(r)
end

matrix = Matrix[*rows]

(0...SQUARES.length).each do |i|
  row_sum = matrix.row(i).reduce(0, :+)
  column_sum = matrix.column(i).reduce(0, :+)
  puts "[#{i}] row: #{row_sum}, column: #{column_sum}"
end

m = matrix**50
#puts m.to_s

puts m.row(0).each_with_index.max_by(3) { |v, _| v }