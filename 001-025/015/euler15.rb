def choose(n, k)
  (n - k + 1..n).reduce(:*) / (1..k).reduce(:*)
end

answer = choose(40, 20)

puts answer
