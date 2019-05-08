require 'set'

# class Set
#   def subsets
#     a = to_a
#     (0..size()).flat_map { |s| a.combination(s).map(&:to_set) }
#   end
# end

class SpecialSumSet
  attr_reader :elements, :present_subset_sums, :min_max_subset_sums

  def initialize(elements = [], present_subset_sums = [true], min_max_subset_sums = [[0, 0]])
    @elements = elements
    @present_subset_sums = present_subset_sums
    @min_max_subset_sums = min_max_subset_sums
  end

  def initialize_dup(special_sum_set)
    @elements = special_sum_set.elements.dup
    @present_subset_sums = special_sum_set.present_subset_sums.dup
    @min_max_subset_sums = special_sum_set.min_max_subset_sums.map(&:dup)
  end

  def no_subset_sums_with_difference?(difference)
    # condition (i)
    # return false if there are already subset_sums whose difference is 'difference'
    @present_subset_sums.each_cons(difference + 1).none? { |s| s.first && s.last }
  end

  def add_to_min_max_subset_sums(element)
    l = @min_max_subset_sums.last
    [[0, 0]] + @min_max_subset_sums.each_cons(2).map { |p, c| [[p.first + element, c.first].min, [p.last + element, c.last].max] } + [[l.first + element, l.last + element]]
  end

  def no_smaller_subsets_with_bigger_sums?(element)
    # condition (ii)
    # return false if adding 'element' would result in a subset with a higher sum than another, bigger subset
    add_to_min_max_subset_sums(element).each_cons(2).none? { |p, c| p.last >= c.first }
  end

  def addable?(element)
#    puts "#{self}, addable?(#{element})"
    r = !@elements.include?(element) && no_subset_sums_with_difference?(element) && no_smaller_subsets_with_bigger_sums?(element)
#    puts "#{r}"
    r
  end

  def <<(element)
    # assumes addable?(element)
    @elements << element
    @present_subset_sums += Array.new(element - @present_subset_sums.size, false) if element > @present_subset_sums.size
    @present_subset_sums = @present_subset_sums[0...element] + @present_subset_sums.each_cons(element + 1).map { |s| s.first || s.last } + @present_subset_sums[-element..-1]
    @min_max_subset_sums = add_to_min_max_subset_sums(element)
  end

  def size
    @elements.size
  end

  def sum
    @present_subset_sums.size - 1
  end

  def to_s
    "<#{@elements}, #{@present_subset_sums}, #{@min_max_subset_sums}>"
  end
end

def finish_special_sum_set(special_sum_set, remaining_size, remaining_sum, next_element)
  return special_sum_set if remaining_size.zero?

  # the remaining r spaces will at a minimum be occupied by next_element, next_element + 1,..., next_element + r - 1, 
  # so if the sum of those remaining spaces will be higher than the remaining sum, constructing a special sum set
  # is impossible
  return nil if remaining_size * (remaining_size + 2 * next_element - 1) / 2 > remaining_sum
  
  # the maximum element cannot be bigger than the sum of the two smallest ones, or else it would violate condition (ii)
  max_element = special_sum_set.size > 1 ? [remaining_sum, special_sum_set.elements[0] + special_sum_set.elements[1] - 1].min : remaining_sum
  (next_element..max_element).each do |element|
    next unless special_sum_set.addable?(element)

    special_sum_set_dup = special_sum_set.dup
    special_sum_set_dup << element
    if result = finish_special_sum_set(special_sum_set_dup, remaining_size - 1, remaining_sum - element, next_element + 1)
      return result
    end
  end
  nil
end

# s = SpecialSumSet.new([3, 5, 6], [true, false, false, true, false, true, true, false, true, true, false, true, false, false, true], [[0, 0], [3, 6], [8, 11], [14, 14]])

# puts s.addable?(7).to_s

# puts s.to_s

# s << 7

# puts s.to_s

puts finish_special_sum_set(SpecialSumSet.new, 6, 115, 1).to_s

