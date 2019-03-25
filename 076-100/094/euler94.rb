MAX_PERIMETER = 1_000_000_000

# see https://oeis.org/A120893 (sequence of the length of the legs)
perimeters = [12, -12].cycle.reduce([16, 50]) do |acc, n|
  next_perimeter = 4 * acc[-1] - acc[-2] + n
  break acc unless next_perimeter <= MAX_PERIMETER

  acc << next_perimeter
end

answer = perimeters.reduce(:+)

puts answer
