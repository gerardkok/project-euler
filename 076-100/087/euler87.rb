require 'prime'
require 'set'

MAX = 50_000_000

combinations = Prime.take_while { |p| p**4 < MAX }.map { |p| p**4 }.each_with_object([].to_set) do |f, result|
  Prime.take_while { |c| c**3 < MAX - f }.map { |p| p**3 }.each do |c|
    Prime.take_while { |s| s**2 < MAX - f - c }.map { |p| p**2 }.each do |s|
      result << f + c + s
    end
  end
end

puts combinations.length
