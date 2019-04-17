def generating_function(n)
  1 - n + n**2 - n**3 + n**4 - n**5 + n**6 - n**7 + n**8 - n**9 + n**10
end

def choose(n, k)
  (n - k + 1..n).reduce(1, :*) / (1..k).reduce(1, :*)
end

def fit(k)
  (1..k).map { |j| generating_function(j) * (-1)**(k - j) * choose(k, j - 1) }.reduce(:+)
end

answer = (1..10).map { |k| fit(k) }.reduce(:+)

puts answer
