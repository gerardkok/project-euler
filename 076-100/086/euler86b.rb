class Integer
  def square?
    (Math.sqrt(self) % 1).zero?
  end
end

def count_shortest_paths(l)
  (1..l).reduce([]) do |memo, b_plus_h|
    # l is short side
    short_count = if (l**2 + b_plus_h**2).square?
      puts "short l: #{l}, b+h: #{b_plus_h}"
      a = l
      b = b_plus_h
      c = Math.sqrt(l**2 + b_plus_h**2).to_i
      [[a, b, c]]
    else
      []
    end

    # l is long side
    puts "l: #{l}, l+b+h: #{l + b_plus_h}, c: #{Math.sqrt(l**2 + (l + b_plus_h)**2)}" if l == 7 && b_plus_h == 5
    long_count = if (l**2 + (l + b_plus_h)**2).square?
      puts "long l: #{l}, b+h: #{b_plus_h}, l+b+h: #{l + b_plus_h}"
      a = l
      b = l + b_plus_h
      c = Math.sqrt(l**2 + (l + b_plus_h)**2).to_i
      [[a, b, c]]
    else
      []
    end

    memo + short_count + long_count
  end
end

cuboid_shortests_paths = Hash.new { |h, k| h[k] = h[k - 1] + count_shortest_paths(k) }.update(1 => [])

cuboid_shortests_paths[10].each_with_index do |c, i|
  puts "[#{i}]: #{c}"
end