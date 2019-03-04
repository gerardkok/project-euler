class Dice
  attr_reader :sum, :double
  alias double? double

  FACES = 4

  def initialize
    one = rand(FACES).next
    other = rand(FACES).next
    @sum = one + other
    @double = (one == other)
  end
end

class Board
  SQUARES = [:GO, :A1, :CC1, :A2, :T1, :R1, :B1, :CH1, :B2, :B3,
             :JAIL, :C1, :U1, :C2, :C3, :R2, :D1, :CC2, :D2, :D3,
             :FP, :E1, :CH2, :E2, :E3, :R3, :F1, :F2, :U2, :F3,
             :G2J, :G1, :G2, :CC3, :G3, :R4, :CH3, :H1, :T2, :H2].freeze
  CC = [:GO, :JAIL, *Array.new(14, :ignore)].freeze
  CH = [:GO, :JAIL, :C1, :E3, :H2, :R1, :next_R, :next_R, :next_U, :back_3, *Array.new(6, :ignore)].freeze

  def initialize
    @position = :GO
    @cc_deck = CC.shuffle
    @ch_deck = CH.shuffle
    @consecutive_doubles = 0
  end

  def index
    SQUARES.index(@position)
  end

  def advance(steps)
    SQUARES[(index + steps) % SQUARES.length]
  end

  def retreat(steps)
    SQUARES[(index + SQUARES.length - steps) % SQUARES.length]
  end

  def roll
    dice = Dice.new
    @consecutive_doubles = dice.double? ? @consecutive_doubles + 1 : 0
    if @consecutive_doubles == 3
      go_to_jail
    else
      @position = advance(dice.sum)
      chance_card if chance?
      community_chest_card if community_chest?
      go_to_jail if @position == :G2J
    end
  end

  def go_to_jail
    @consecutive_doubles = 0
    @position = :JAIL
  end

  def chance?
    [:CH1, :CH2, :CH3].include?(@position)
  end

  def community_chest?
    [:CC1, :CC2, :CC3].include?(@position)
  end

  def next_railway
    case @position
    when :CH1 then :R2
    when :CH2 then :R3
    else :R1
    end
  end

  def next_utility
    (@position == :CH2) ? :U2 : :U1
  end

  def chance_card
    card = @ch_deck.first
    @ch_deck.rotate!
    if [:GO, :JAIL, :C1, :E3, :H2, :R1].include?(card)
      @position = card
    elsif card == :next_R
      @position = next_railway
    elsif card == :next_U
      @position = next_utility
    elsif card == :back_3
      @position = retreat(3)
    end
  end

  def community_chest_card
    card = @cc_deck.first
    @cc_deck.rotate!
    @position = card unless card == :ignore
  end
end

board = Board.new

freqs = 10_000_000.times.each_with_object(Hash.new(0)) do |_, result|
  board.roll
  result[board.index] += 1
end

answer = freqs.max_by(3, &:last).map(&:first).map { |n| '%02d' % n }.join

puts answer
