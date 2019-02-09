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

def cycle_of_six(start, figurates, cycle_so_far = [])
  return cycle_so_far if cycle_so_far.length == 6 && cycle_so_far.first.first == start

  figurates[start].each do |type, next_steps|
    next if cycle_so_far.map(&:last).include?(type)

    next_steps.each do |step|
      c = cycle_of_six(step, figurates, cycle_so_far + [[start, type]])
      return c if c
    end
  end
  nil
end

figurates = 1.step.each_with_object({}) do |n, result|
  numbers = POLYGONAL_TYPES.each_with_object({}) { |p, r| r[p] = polygonal(n, p).to_s }
  break result if numbers.values.map(&:length).all? { |l| l > 4 }

  numbers.select { |_, p| p.length == 4 }.each do |t, p|
    f, l = p.scan(%r{(..)(..)}).sample
    next if l.start_with?('0')

    result[f] ||= {}
    (result[f][t] ||= []) << l
  end
end

cycle = figurates.keys.each do |k|
  c = cycle_of_six(k, figurates)
  break c if c
end

answer = cycle.map(&:first).map(&:to_i).map { |n| n * 101 }.reduce(:+)

puts answer
