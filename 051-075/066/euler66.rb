class Integer
  def square?
    (Math.sqrt(self) % 1).zero?
  end
end

def continued_fraction_period(number, s, m = 0, d = 1, a = nil)
  # see https://en.wikipedia.org/wiki/Methods_of_computing_square_roots#Algorithm
  return [] if (a ||= s) == 2 * s

  m = d * a - m
  d = (number - m**2) / d
  a = ((s + m) / d).to_i
  [a] + continued_fraction_period(number, s, m, d, a)
end

def numerator(a0, period, i)
  numerators = (0...i).reduce([1, a0]) do |result, k|
    result << period[k % period.length] * result[-1] + result[-2]
  end
  numerators.last
end

def min_solution_of_x(d)
  # algorithm from https://ir.canterbury.ac.nz/bitstream/handle/10092/10158/unger_2009_report.pdf
  a0 = Math.sqrt(d).to_i
  period = continued_fraction_period(d, a0)
  period.length.even? ? numerator(a0, period, period.length - 1) : numerator(a0, period, 2 * period.length - 1)
end

answer = (1..1_000).reject(&:square?).max_by { |d| min_solution_of_x(d) }

puts answer
