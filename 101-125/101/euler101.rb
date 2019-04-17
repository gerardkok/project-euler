def generating_function(n)
  1 - n + n**2 - n**3 + n**4 - n**5 + n**6 - n**7 + n**8 - n**9 + n**10
end

base = Array.new(10) { |i| generating_function(i + 1) }

answer = base.reduce(:+)
while base.length > 1
  base = base.each_cons(2).map { |n, m| m - n }
  answer += base.reduce(:+)
end

puts answer
