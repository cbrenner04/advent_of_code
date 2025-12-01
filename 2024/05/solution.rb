# frozen_string_literal: true

# INPUT = "47|53
# 97|13
# 97|61
# 97|47
# 75|29
# 61|13
# 75|53
# 29|13
# 97|29
# 53|29
# 61|53
# 97|53
# 61|29
# 47|13
# 75|47
# 97|75
# 47|61
# 75|61
# 47|29
# 75|13
# 53|13

# 75,47,61,53,29
# 97,61,53,29,13
# 75,29,13
# 75,97,47,61,53
# 61,13,29
# 97,13,75,29,47"

def topological_sort(nodes, edges)
  sorted = []
  visited = {}
  queue = {}

  define_singleton_method(:visit) do |node|
    return true if visited[node] # Already added to sorted list
    return false if queue[node] # Cycle detected

    queue[node] = true
    edges[node]&.each { |neighbor| false unless visit(neighbor) }
    queue.delete(node)
    visited[node] = true
    sorted.unshift(node)
  end

  nodes.each { |node| return [] unless visit(node) } # Cycle detected

  sorted
end

inputs = INPUT.split("\n\n")
rules = {}
inputs.first.each_line do |rule|
  rs = rule.chomp.split("|")
  (rules[rs.first] ||= []) << rs.last
end

pages = inputs.last.split("\n")
correct_pages = []
incorrect_pages = []
pages.each do |page|
  split = page.chomp.split(",")
  correctness = split.each_with_index.flat_map do |p, i|
    second_pages = rules[p]
    next unless second_pages

    second_pages.map do |second_page|
      second_page_index = split.index(second_page)
      next unless second_page_index

      i < second_page_index
    end
  end
  correctness.compact.all?(true) ? correct_pages << split : incorrect_pages << split
end

p correct_pages.map { |correct| correct[(correct.count / 2).ceil].to_i }.compact.reduce(:+)

# part two
reordered_pages = incorrect_pages.map do |update|
  unique_pages = update.uniq
  applicable_rules = rules.select { |key, _| unique_pages.include?(key) }
  edges = Hash.new { |h, k| h[k] = [] }

  applicable_rules.each do |from, tos|
    tos.each { |to| edges[from] << to if unique_pages.include?(to) }
  end

  sorted = topological_sort(unique_pages, edges)
  raise "Cycle detected in rules for update: #{update.join(',')}" if sorted.empty?

  sorted
end

# Compute middle page numbers for reordered updates
reordered_middles = reordered_pages.map { |update| update[update.size / 2].to_i }
p reordered_middles.reduce(:+)
