SINGLE_DART_SCORES = ((1..20).flat_map { |i| [i, 2 * i, 3 * i] } + [0, 25, 50]).freeze
DOUBLE_SCORES = ((1..20).map { |r| r * 2 } + [25 * 2]).freeze

checkouts = SINGLE_DART_SCORES.each_with_index.flat_map do |first_dart, i|
  SINGLE_DART_SCORES[i..-1].flat_map do |second_dart|
    DOUBLE_SCORES.map { |final_dart| [first_dart, second_dart, final_dart] }
  end
end

answer = checkouts.count { |checkout| checkout.reduce(:+) < 100 }

puts answer
