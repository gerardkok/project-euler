# adapted from https://rosettacode.org/wiki/Poker_hand_analyser#Ruby

class Card
  include Comparable
  attr_reader :suit, :face

  SUITS = [:S, :H, :D, :C].freeze
  FACES = [:'2', :'3', :'4', :'5', :'6', :'7', :'8', :'9', :T, :J, :Q, :K, :A].freeze

  def initialize(str)
    @face, @suit = str.chars.map(&:to_sym)
  end

  def <=>(other)
    rank <=> other.rank
  end

  def rank
    FACES.index(@face)
  end
end

class Hand
  include Comparable

  RANKS = [:'high-card', :'one-pair', :'two-pairs', :'three-of-a-kind', :straight, :flush, :'full-house', :'four-of-a-kind', :'straight-flush', :'royal-flush'].freeze

  def initialize(str_of_cards)
    @cards = str_of_cards.split.map { |str| Card.new(str) }
  end

  def <=>(other)
    value <=> other.value
  end

  def value
    tiebreaker = card_values.map { |c| [c.size, c.first.rank] }.sort.reverse
    [RANKS.index(rank), tiebreaker]
  end

  def one_suit?
    @cards.map(&:suit).uniq.size == 1
  end

  def consecutive?
    @cards.sort.each_cons(2).all? { |c1, c2| c2.rank - c1.rank == 1 }
  end

  def royal?
    @cards.max.face == :A
  end

  def card_values
    @cards.group_by(&:face).values
  end

  def face_pattern
    card_values.map(&:size).sort
  end

  def rank
    if consecutive? && one_suit?
      royal? ? :'royal-flush' : :'straight-flush'
    elsif consecutive?
      :straight
    elsif one_suit?
      :flush
    else
      case face_pattern
      when [1, 1, 1, 1, 1] then :'high-card'
      when [1, 1, 1, 2] then :'one-pair'
      when [1, 2, 2] then :'two-pairs'
      when [1, 1, 3] then :'three-of-a-kind'
      when [2, 3] then :'full-house'
      when [1, 4] then :'four-of-a-kind'
      end
    end
  end
end

player1wins = File.readlines('input54.txt').select do |line|
  hand1, hand2 = line.scan(%r{(.{14}) (.{14})}).sample.map { |h| Hand.new(h) }
  hand1 > hand2
end

answer = player1wins.length

puts answer
