class Rational
  def numerator_gt_denominator?
    numerator.to_s.length > denominator.to_s.length
  end
end

exps = [Rational(1, 1)]
exps << Rational(exps[-1].numerator + 2 * exps[-1].denominator, exps[-1].numerator + exps[-1].denominator) while exps.length < 1_000

answer = exps.select(&:numerator_gt_denominator?).length

puts answer
