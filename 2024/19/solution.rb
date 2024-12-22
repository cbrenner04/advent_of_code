# frozen_string_literal: true

# INPUT = "r, wr, b, g, bwu, rb, gb, br

# brwrr
# bggr
# gbbr
# rrbgbr
# ubwu
# bwurrg
# brgr
# bbrgwb"

# # not efficient enough
# def find_combinations(towels, design, path = [], results = [])
#   # return results with path when design has been fully matched
#   return results.append(path) if design.empty?

#   towels.each do |towel|
#     # we only want to move forward when the towel is the first thing in the design substring
#     # this avoids missing paths due to matching in any part
#     next unless design.start_with?(towel)

#     # recursively iterate through the design with the towels to find the rest of the paths
#     find_combinations(towels, design.slice(towel.length, design.length), path << towel, results)
#   end

#   results
# end

# towels = INPUT.split("\n\n").first.split(", ")
# designs = INPUT.split("\n\n").last.each_line(chomp: true).to_a

# good_designs = 0
# designs.each { |design| good_designs += 1 unless find_combinations(towels, design).empty? }
# p good_designs

# gpt'ed
def can_form_design(patterns, design)
  memo = {}

  # Recursive backtracking function with memoization
  define_singleton_method(:backtrack) do |remaining|
    return true if remaining.empty?
    return memo[remaining] unless memo[remaining].nil?

    patterns.each do |pattern|
      if remaining.start_with?(pattern) && backtrack(remaining[pattern.length..])
        memo[remaining] = true
        return true
      end
    end

    memo[remaining] = false
    false
  end

  backtrack(design)
end

towels = INPUT.split("\n\n").first.split(", ")
designs = INPUT.split("\n\n").last.each_line(chomp: true).to_a
possible_count = 0
designs.each { |design| possible_count += 1 if can_form_design(towels, design) }
p possible_count
