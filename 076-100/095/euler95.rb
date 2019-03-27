MAX_ELEMENT = 1_000_000

divisor_sums = (1..MAX_ELEMENT / 2).each_with_object(Array.new(MAX_ELEMENT + 1, 0)) do |n, acc|
  (2 * n..MAX_ELEMENT).step(n) do |f|
    acc[f] += n
  end
end

def amicable_chain_length(n, divisor_sums)
  next_n = n
  chain = [n]
  while (next_n = divisor_sums[next_n]).between?(n, MAX_ELEMENT)
    break if chain.include?(next_n)

    chain << next_n
  end
  (n == next_n) ? chain.length : 0
end

amicable_chain_lengths = Array.new(MAX_ELEMENT + 1) { |n| amicable_chain_length(n, divisor_sums) }

answer = amicable_chain_lengths.index(amicable_chain_lengths.max)

puts answer
