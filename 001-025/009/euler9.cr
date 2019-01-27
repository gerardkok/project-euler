def answer
  (1..23).each do |m|
    (1..m).each do |n|
      triplet_sum = 2 * m * (m + n)
      triplet_product = 2 * m * n * (m**4 - n**4)
      return triplet_product if triplet_sum == 1_000
    end
  end
end

puts answer
