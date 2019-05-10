N = 12

def choose(n, k)
  (n - k + 1..n).reduce(:*) / (1..k).reduce(:*)
end

def catalan_number(n)
  choose(2 * n, n) / (n + 1)
end

answer = (2..N / 2).map { |n| choose(N, 2 * n) * (choose(2 * n, n) / 2 - catalan_number(n)) }.reduce(:+)

puts answer
