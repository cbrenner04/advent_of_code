# frozen_string_literal: true

# After lots of struggle, I found out topological sort is the name of the game

# none of the following gets to the correct sort for part 1

# https://en.wikipedia.org/wiki/Topological_sorting

# Kahn's algorithm

# L <- Empty list that will contain the sorted elements
# S <- Set of all nodes with no incoming edge
# while S is non-empty do
#     remove a node n from S
#     add n to tail of L
#     for each node m with an edge e from n to m do
#         remove edge e from the graph
#         if m has no other incoming edges then
#             insert m into S
# if graph has edges then
#     return error (graph has at least one cycle)
# else
#     return L (a topologically sorted order)

KahnNode = Struct.new(:from, :to)

nodes = parsed_data.map { |d| KahnNode.new(d.first, d.last) }
list = []
next_nodes = []
next_nodes << nodes.first

until next_nodes.empty?
  next_node = next_nodes.shift
  list << next_node
end

# Depth-first search

# function visit(node n)
#   if n has a permanent mark then return
#   if n has a temporary mark then stop (not a DAG)
#   mark n temporarily
#   for each node m with an edge from n to m do
#       visit(m)
#   mark n permanently
#   add n to head of L

# L <- Empty list that will contain the sorted nodes
# while there are unmarked nodes do
#     select an unmarked node n
#     visit(n)

def visit(current_node, nodes, list)
  return if %w[permanent temporary].include?(current_node.marked)
  current_node.marked = "temporary"
  nodes.each { |node| visit(node, nodes, list) if node.from == current_node.to }
  current_node.marked = "permanent"
  list.unshift(current_node.from) unless list.include?(current_node.from)
end

def map_unmarked(nodes)
  nodes.select { |n| n.marked == "unmarked" }
end

DeptFirstNode = Struct.new(:from, :to, :marked)

nodes = parsed_data.map { |d| DeptFirstNode.new(d.first, d.last, "unmarked") }
list = []
unmarked_nodes = map_unmarked(nodes)

until unmarked_nodes.empty?
  visit(unmarked_nodes.first, nodes, list)
  unmarked_nodes = map_unmarked(nodes)
end

# need to get the `to` from the last instruction
last = nodes.find { |n| list.last == n.from }
list << last.to

puts "Part one: #{list.join}"

# The following comes from
# https://github.com/brianstorti/ruby-graph-algorithms/tree/master/topological_sort

# top level graph that holds the nodes
class Graph
  attr_accessor :nodes

  def initialize
    @nodes = []
  end

  def add_edge(from, to)
    from.adjacents << to
  end
end

require "set"

# represents a single node in the graph
class Node
  attr_accessor :name, :adjacents

  def initialize(name)
    @adjacents = Set.new
    @name = name
  end

  def to_s
    @name
  end
end

# object for sorting
class TopologicalSort
  attr_accessor :post_order

  def initialize(graph)
    @post_order = []
    @visited = []

    graph.nodes.each do |node|
      dfs(node) unless @visited.include?(node)
    end
  end

  private

  def dfs(node)
    @visited << node
    node.adjacents.each do |adj_node|
      dfs(adj_node) unless @visited.include?(adj_node)
    end

    @post_order << node
  end
end

keys = instruction_hash.keys
graph = Graph.new
graph.nodes = keys.map { |k| Node.new(k) }

instruction_hash.each do |key, dependents|
  dependents.each do |dependent|
    from = graph.nodes.find { |n| n.to_s == key }
    to = graph.nodes.find { |n| n.to_s == dependent }
    unless to
      to = Node.new(dependent)
      graph.nodes << to
    end
    graph.add_edge(from, to)
  end
end

sorted = TopologicalSort.new(graph).post_order.map(&:to_s).reverse.join
puts "Part one: #{sorted}"

# trying ruby's sort

require "tsort"

# add TSort to Hash and a method to run the sort
class Hash
  include TSort
  alias tsort_each_node each_key
  def tsort_each_child(node, &block)
    fetch(node).each(&block)
  end
end

keys = instruction_hash.keys
last = instruction_hash[keys.last].last
instruction_hash[last] = []
puts "Part one: #{instruction_hash.tsort.reverse.join}"

# trying unix tsort

data_file = File.join(File.dirname(__FILE__), "data-sort.txt")
output_file = File.join(File.dirname(__FILE__), "out-sort.txt")
system("tsort #{data_file} > #{output_file}")
output = File.open(output_file).each_line.map(&:chomp)
puts "Part one: #{output.join}"
