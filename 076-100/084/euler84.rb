class Dice
  SIZE = 6

  # def initialize
  #   @one = 0
  #   @other = 0
  # end

  def roll
    @one = rand(SIZE).next
    @other = rand(SIZE).next
  end

  def double?
    @one == @other
  end

  def sum
    @one + @other
  end
end

class Board
  attr_accessor :position

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
    @dice = Dice.new
    @consecutive_doubles = 0
  end

  def roll
    @dice.roll
    if @dice.double?
      @consecutive_doubles += 1
    else
      @consecutive_doubles = 0
    end
  end

  def three_consecutive_doubles?
    @consecutive_doubles == 3
  end

  def chance?
    [:CH1, :CH2, :CH3].include?(@position)
  end

  def community_chest?
    [:CC1, :CC2].include?(@position)
  end

  def advance
    if three_consecutive_doubles?
      @consecutive_doubles = 0
      @position = :JAIL
    else
      @position = SQUARES[(SQUARES.index(@position) + @dice.sum) % SQUARES.length]
      advance_ch if chance?
      advance_cc if community_chest?
      @position = :JAIL if @position == :G2J
    end
  end

  def advance_ch
    card = @ch_deck.first
    @ch_deck.rotate!
    if [:GO, :JAIL, :C1, :E3, :H2, :R1].include?(card)
      @position = card
    elsif card == :next_R
      @position = case @position
                  when :CH1
                    :R2
                  when :CH2
                    :R3
                  else
                    :R1
                  end
    elsif card == :next_U
      @position = (@position == :CH2) ? :U2 : :U1
    elsif card == :back_3
      @position = SQUARES[(SQUARES.index(@position) + SQUARES.length - 3) % SQUARES.length]
    end
  end

  def advance_cc
    card = @cc_deck.first
    @cc_deck.rotate!
    @position = card unless card == :ignore
  end

  def turn
    roll
    advance
  end
end

board = Board.new

100.times do
  board.turn
  puts board.position.to_s
end
