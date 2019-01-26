class Integer
  IRREGULAR = {
    1 => 'one'.length,
    2 => 'two'.length,
    3 => 'three'.length,
    4 => 'four'.length,
    5 => 'five'.length,
    6 => 'six'.length,
    7 => 'seven'.length,
    8 => 'eight'.length,
    9 => 'nine'.length,
    10 => 'ten'.length,
    11 => 'eleven'.length,
    12 => 'twelve'.length,
    13 => 'thirteen'.length,
    14 => 'fourteen'.length,
    15 => 'fifteen'.length,
    16 => 'sixteen'.length,
    17 => 'seventeen'.length,
    18 => 'eighteen'.length,
    19 => 'nineteen'.length,
    20 => 'twenty'.length,
    30 => 'thirty'.length,
    40 => 'forty'.length,
    50 => 'fifty'.length,
    60 => 'sixty'.length,
    70 => 'seventy'.length,
    80 => 'eighty'.length,
    90 => 'ninety'.length
  }.freeze
  HUNDRED = 'hundred'.length
  ONE_THOUSAND = IRREGULAR[1] + 'thousand'.length
  AND = 'and'.length

  def lettercount
    if IRREGULAR.key?(self)
      IRREGULAR[self]
    elsif self < 100
      tens, units = divmod(10)
      (tens * 10).lettercount + units.lettercount # self is not irregular, so units cannot be zero
    elsif self < 1_000
      hundreds, tens = divmod(100)
      hundreds.lettercount + HUNDRED + (tens.zero? ? 0 : tens.lettercount + AND)
    else # don't account for > 1_000
      ONE_THOUSAND
    end
  end
end

answer = (1..1_000).map(&:lettercount).reduce(:+)

puts answer
