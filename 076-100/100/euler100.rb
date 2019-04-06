MAX_BALLS = 1_000_000_000_000

def total(amount_blue)
  # https://oeis.org/A046090
  (1 + Math.sqrt(1 + 8 * amount_blue * (amount_blue + 1))) / 2
end

# https://oeis.org/A011900
number_of_blue_balls = [1, 3]
number_of_blue_balls << 6 * number_of_blue_balls[-1] - number_of_blue_balls[-2] - 2 until total(number_of_blue_balls[-1]) > MAX_BALLS

answer = number_of_blue_balls.last

puts answer
