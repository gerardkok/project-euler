MAX_ELEMENT = 1_000_000

divisor_sums = (1..MAX_ELEMENT / 2).each_with_object(Array.new(MAX_ELEMENT + 1, 0)) do |n, acc|
  (2 * n..MAX_ELEMENT).step(n) do |f|
    acc[f] += n
  end
end

def find_chain(n, divisor_sums)
  next_n = n
  chain = [next_n]
  while (next_n = divisor_sums[next_n]).between?(n, MAX_ELEMENT)
    return (chain.first == next_n) ? chain : [] if chain.include?(next_n)

    chain << next_n
  end
  []
end

chain_lengths = (2..MAX_ELEMENT).each_with_object(Array.new(MAX_ELEMENT + 1, 0)) do |n, acc|
  next unless acc[n].zero?

  chain = find_chain(n, divisor_sums)
  chain.each do |link|
    acc[link] = chain.length
  end
end

answer = chain_lengths.index(chain_lengths.max)

puts answer
