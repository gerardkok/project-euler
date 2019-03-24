MAX_PERIMETER = 1_000_000_000

def perimeter(a, c)
  2 * (a + c)
end

perimeters = begin
  a = 3
  b = 4
  c = 5
  result = []
  while (perimeter = perimeter(a, c)) <= MAX_PERIMETER
    result << perimeter
    a, b, c = -2 * a + b + 2 * c, -a + 2 * b + 2 * c, -2 * a + 2 * b + 3 * c
  end
  result
end

answer = perimeters.reduce(:+)

puts answer
