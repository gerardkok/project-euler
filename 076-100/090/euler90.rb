def six_for_nine(faces)
  faces.map { |face| (face == '9') ? '6' : face }
end

class Dice
  SQUARES = ['01', '04', '09', '16', '25', '36', '49', '64', '81'].map { |s| s.tr('9', '6') }.freeze

  def initialize(one, other)
    @one = six_for_nine(one)
    @other = six_for_nine(other)
  end

  def valid_for_square?(square)
    (@one.include?(square[0]) && @other.include?(square[1])) ||
      (@other.include?(square[0]) && @one.include?(square[1]))
  end

  def valid?
    SQUARES.all? { |s| valid_for_square?(s) }
  end
end

face_combinations = ('0'..'9').to_a.combination(6).to_a

# the dice are interchangeable, so each die combination appears twice, so we need to half the final answer
answer = face_combinations.product(face_combinations).map { |f, s| Dice.new(f, s) }.count(&:valid?) / 2

puts answer
