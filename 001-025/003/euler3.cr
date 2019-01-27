def largest_prime_factor(number : Int64)
  factor = 2
  while factor <= number / 2
    quotient, remainder = number.divmod(factor)
    if remainder.zero?
      number = quotient
    else
      factor += 1
    end
  end
  number
end

answer = largest_prime_factor(600_851_475_143)

puts answer
