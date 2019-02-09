POLYGONAL_TYPES = [:triangle, :square, :pentagonal, :hexagonal, :heptagonal, :octagonal].freeze

def polygonal(number, type)
  case type
  when :triangle
    number * (number + 1) / 2
  when :square
    number * number
  when :pentagonal
    number * (3 * number - 1) / 2
  when :hexagonal
    number * (2 * number - 1)
  when :heptagonal
    number * (5 * number - 3) / 2
  when :octagonal
    number * (3 * number - 2)
  end
end

figurates = 1.step.each_with_object({}) do |n, result|
  numbers = POLYGONAL_TYPES.each_with_object({}) { |p, r| r[p] = polygonal(n, p) }
  break result if numbers.values.all? { |p| p > 9_999 }

  numbers.select { |_, p| p.between?(1_000, 9_999) }.each do |t, p|
    _, f, l = p.to_s.partition(%r{..})
    next if l.start_with?('0')

    result[f] ||= {}
    (result[f][t] ||= []) << l
  end
end

puts figurates.to_s
