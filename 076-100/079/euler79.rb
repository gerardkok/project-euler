require 'tsort'

class Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end

dependencies = File.readlines('input79.txt').map(&:chomp).each_with_object({}) do |line, result|
  line.chars.each_cons(2) do |from, to|
    result[from] ||= []
    result[to] ||= []
    result[to] << from unless result[to].include?(from)
  end
end

answer = dependencies.tsort.join # assuming there are no cycles

puts answer
