def pentagonal(k)
  k * (3 * k - 1) / 2
end

# https://en.wikipedia.org/wiki/Pentagonal_number_theorem
p = Hash.new do |h, n|
  h[n] = 1.step.lazy.flat_map { |k| [k, -k] }.reduce(0) do |result, k|
    pentagonal_number = pentagonal(k)
    break result if n < pentagonal_number

    sign = k.odd? ? 1 : -1
    (result + sign * h[n - pentagonal_number]) % 1_000_000 # avoid big numbers by using mod here
  end
end.update(0 => 1)

answer = 1.step.find { |n| p[n].zero? }

puts answer
