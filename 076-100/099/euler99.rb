lines = File.open('input99.txt').readlines.map(&:chomp)

logs = lines.map { |line| line.split(',').map(&:to_i) }.map { |a, b| b * Math.log(a) }

answer = logs.unshift(0).each_with_index.max_by { |n, _| n }.last

puts answer
