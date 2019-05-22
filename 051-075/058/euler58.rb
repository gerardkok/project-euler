require 'prime'

def number_of_corner_primes(spiral_index)
  a = 2 * spiral_index
  b = a**2 + 1
  [b - a, b, b + a].count(&:prime?) # lower right corner is always a square, so never prime
end

number_of_primes = Hash.new { |h, key| h[key] = number_of_corner_primes(key) + h[key - 1] }.update(0 => 0)

index = 1.step.lazy.find { |n| 100 * number_of_primes[n] / (4 * n + 1) < 10 }

answer = 2 * index + 1

puts answer
