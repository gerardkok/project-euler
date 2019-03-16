SIZE = 50

def right_angle_in_point(p_x, p_y)
  f = p_x.gcd(p_y)
  delta_x = p_x / f
  delta_y = p_y / f
  count = 0
  q_x = p_x
  q_y = p_y
  count += 1 while (q_x -= delta_y) >= 0 && (q_y += delta_x) <= SIZE
  q_x = p_x
  q_y = p_y
  count += 1 while (q_x += delta_y) <= SIZE && (q_y -= delta_x) >= 0
  (p_x == p_y) ? count : 2 * count
end

right_angle_on_axis = 3 * SIZE**2

right_angle_in_quadrant = (1..SIZE).reduce(0) do |acc_x, p_x|
  acc_x + (1..p_x).reduce(0) do |acc_y, p_y|
    acc_y + right_angle_in_point(p_x, p_y)
  end
end

answer = right_angle_on_axis + right_angle_in_quadrant

puts answer
