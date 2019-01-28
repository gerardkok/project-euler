require 'prime'

def number_of_corner_primes(spiral_index)
  l = (2 * spiral_index - 1)**2
  s = 2 * spiral_index - 2
  r = [l - 3 * s, l - 2 * s, l - s].count(&:prime?)
end

$number_of_primes = Hash.new { |h, key| h[key] = number_of_corner_primes(key) }.update(1 => 0)

def acc_number_of_primes(spiral_index)
  (1..spiral_index).map { |n| $number_of_primes[n] }.reduce(:+)
end

index = 2.step.lazy.find { |n| 100 * acc_number_of_primes(n) / (4 * n - 3) < 10 }

#index = (10000..11000).find { |n| a = acc_number_of_primes(n); d = (4 * n - 3); r = 100 * a / d; puts "n: #{n}, a: #{a}, d: #{d}, r: #{r}"; r < 10 }

answer = 2 * index - 1

puts answer
