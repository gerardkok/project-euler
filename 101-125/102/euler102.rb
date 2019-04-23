# https://stackoverflow.com/questions/2049582/how-to-determine-if-a-point-is-in-a-2d-triangle

def sign(p_x, p_y, q_x, q_y)
  (p_x - q_x) * q_y - q_x * (p_y - q_y)
end

def origin_in_triangle?(triangle)
  a_x, a_y, b_x, b_y, c_x, c_y = *triangle

  d1 = sign(a_x, a_y, b_x, b_y)
  d2 = sign(b_x, b_y, c_x, c_y)
  d3 = sign(c_x, c_y, a_x, a_y)

  negative = d1.negative? || d2.negative? || d3.negative?
  positive = d1.positive? || d2.positive? || d3.positive?

  !(negative && positive)
end

lines = File.open('input102.txt').readlines.map(&:chomp)

answer = lines.map { |line| line.split(',').map(&:to_i) }.count { |triangle| origin_in_triangle?(triangle) }

puts answer
