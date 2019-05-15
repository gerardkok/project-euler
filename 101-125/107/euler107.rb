class UnionFind
  # from https://github.com/gastropoda/algorithms2/blob/master/kruskals_union_set.rb
  def initialize
    @subsets = Hash.new { |subsets, element| subsets[element] = [element] }
  end

  def connected?(id1, id2)
    @subsets[id1] == @subsets[id2]
  end

  def union(id1, id2)
    return if @subsets[id1] == @subsets[id2]

    @subsets[id1].each do |element|
      @subsets[element] = @subsets[id2] << element
    end
  end
end

edges = File.open('input107.txt').each_with_index.each_with_object({}) do |(line, from), memo|
  line.split(',').each_with_index do |weight, to|
    next if weight == '-' || from <= to # skip duplicates

    memo[[from, to]] = weight.to_i
  end
end

network_cost = edges.values.reduce(:+)

disjoint_set = UnionFind.new

minimum_spanning_tree_weights = edges.sort_by(&:last).each_with_object([]) do |((from, to), weight), memo|
  next if disjoint_set.connected?(from, to)

  disjoint_set.union(from, to)
  memo << weight
end

minimum_spanning_tree_cost = minimum_spanning_tree_weights.reduce(:+)

answer = network_cost - minimum_spanning_tree_cost

puts answer
