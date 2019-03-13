require 'set'

MAX_K = 6
MAX_N = 2 * MAX_K

factors = (2..MAX_N).each_with_object(Array.new(MAX_N + 1) { |_| [] }) do |n, acc|
  max_power = (Math.log(MAX_N) / Math.log(n)).to_i
  (1..max_power).each do |power|
    factor = n**power
    factorization = [n] * power
    (factor..MAX_N).step(factor).each_with_index do |f, i|
      next if i + 1 < n
      acc[f] << [*factorization, i + 1]
    end
  end
end

factors.each_with_index do |f, i|
  puts "[#{i}]: #{f.to_a}"
end
