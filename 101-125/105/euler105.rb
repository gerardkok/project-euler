class Array
  def powerset
    (0..size).flat_map { |s| combination(s).to_a }
  end

  def no_smaller_subsets_with_bigger_sums?
    (2..size / 2 + 1).all? { |l| self[0...l].reduce(:+) > self[1 - l..-1].reduce(:+) }
  end

  def no_subsets_with_equal_sums?
    total = (2..size / 2).each_with_object([]) do |k, memo|
      (0..size - 1).to_a.combination(k).each do |s1|
        elements_left = (0..size - 1).to_a - s1
        elements_left.combination(k).each do |s2|
          next if s1.first > s2.first

          memo << [s1, s2] unless s1.zip(s2).all? { |x, y| x < y }
        end
      end
    end
    puts "total: #{total}"
    puts "#total: #{total.size}"
  end
end

puts [2, 3, 4].no_smaller_subsets_with_bigger_sums?.to_s

puts [1, 2, 3, 4].no_smaller_subsets_with_bigger_sums?.to_s

puts [1].no_smaller_subsets_with_bigger_sums?.to_s

(0..3).to_a.no_subsets_with_equal_sums?

(0..6).to_a.no_subsets_with_equal_sums?

(0..11).to_a.no_subsets_with_equal_sums?
