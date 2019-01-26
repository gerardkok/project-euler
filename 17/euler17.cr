struct Int
  IRREGULAR = {
    1 => "one".size,
    2 => "two".size,
    3 => "three".size,
    4 => "four".size,
    5 => "five".size,
    6 => "six".size,
    7 => "seven".size,
    8 => "eight".size,
    9 => "nine".size,
    10 => "ten".size,
    11 => "eleven".size,
    12 => "twelve".size,
    13 => "thirteen".size,
    14 => "fourteen".size,
    15 => "fifteen".size,
    16 => "sixteen".size,
    17 => "seventeen".size,
    18 => "eighteen".size,
    19 => "nineteen".size,
    20 => "twenty".size,
    30 => "thirty".size,
    40 => "forty".size,
    50 => "fifty".size,
    60 => "sixty".size,
    70 => "seventy".size,
    80 => "eighty".size,
    90 => "ninety".size
  }
  HUNDRED = "hundred".size
  ONE_THOUSAND = IRREGULAR[1] + "thousand".size
  AND = "and".size

  def lettercount
    if IRREGULAR.has_key?(self)
      IRREGULAR[self]
    elsif self < 100
      tens, units = divmod(10)
      (tens * 10).lettercount + (units.zero? ? 0 : units.lettercount)
    elsif self < 1_000
      hundreds, tens = divmod(100)
      hundreds.lettercount + HUNDRED + (tens.zero? ? 0 : tens.lettercount + AND)
    else # don"t account for > 1_000
      ONE_THOUSAND
    end
  end
end

answer = (1..1_000).map(&.lettercount).sum

puts answer
