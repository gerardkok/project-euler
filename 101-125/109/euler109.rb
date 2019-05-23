SINGLE_DART_SCORES = ((1..20).flat_map { |i| [i, 2 * i, 3 * i] } + [25, 50]).freeze
DOUBLE_SCORES = ((1..20).map { |r| r * 2 } + [25 * 2]).freeze

preceeding_double = (0..2).flat_map { |n| SINGLE_DART_SCORES.combination(n).to_a } + SINGLE_DART_SCORES.map { |s| [s, s] }

checkouts = preceeding_double.product(DOUBLE_SCORES).map(&:flatten)

answer = checkouts.count { |checkout| checkout.reduce(:+) < 100 }

puts answer
