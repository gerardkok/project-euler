MAX_ELEMENT = 1_000_000

divisors = (1..MAX_ELEMENT).each_with_object(Array.new(MAX_ELEMENT + 1) { [] }) do |n, acc|
  (2 * n..MAX_ELEMENT).step(n) do |f|
    acc[f] << n
  end
end

def find_chain(n, divisors, chain_so_far = [])
  divisor_sum = divisors[n].reduce(0, :+)
#  puts "n: #{n}, divisor sum: #{divisor_sum}"
  return [] unless divisor_sum.between?(2, MAX_ELEMENT)

  chain = chain_so_far + [n]
#  puts "chain: #{chain}"
  if chain.include?(divisor_sum)
#    puts "found chain! #{chain}"
    return chain.first == divisor_sum ? chain : []
  end

  find_chain(divisor_sum, divisors, chain)
end

chain_lengths = (2..MAX_ELEMENT).each_with_object(Array.new(MAX_ELEMENT + 1)) do |n, acc|
  unless acc[n]
    chain = find_chain(n, divisors)
    chain.each do |link|
      acc[link] ||= chain.length
    end
  end
end

max_chain = chain_lengths.compact.max

answer = chain_lengths.find_index(max_chain)

puts answer
