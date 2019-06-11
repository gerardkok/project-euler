class UnionFind
  def initialize
    @ids = Hash.new { |ids, id| ids[id] = id }
    @sizes = Hash.new(1)
  end

  def find(index)
    return index if @ids[index] == index

    @ids[index] = @ids[@ids[index]]
    find(@ids[index])
  end

  def connected?(p, q)
    find(p) == find(q)
  end

  def union(p, q)
    return if connected?(p, q)

    root_p = find(p)
    root_q = find(q)
    @ids[root_p] > @ids[root_q] ? join(root_q, root_p) : join(root_p, root_q)
  end

  private

  def join(root1, root2)
    @ids[root1] = root2
    @sizes[root2] += @sizes[root1]
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
