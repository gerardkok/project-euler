MODULO = 10_000_000_000

def mod_exp(n, e, mod)
  prod = 1
  base = n % mod
  until e.zero?
    prod = (prod * base) % mod if e.odd?
    e >>= 1
    base = (base * base) % mod
  end
  prod
end

answer = (28_433 * mod_exp(2, 7_830_457, MODULO) + 1) % MODULO

puts answer
