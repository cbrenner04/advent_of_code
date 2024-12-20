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

# not efficient enough
def find_combinations(towels, design, path = [], results = [])
  # return results with path when design has been fully matched
  return results.append(path) if design.empty?

  towels.each do |towel|
    # we only want to move forward when the towel is the first thing in the design substring
    # this avoids missing paths due to matching in any part
    next unless design.start_with?(towel)

    # recursively iterate through the design with the towels to find the rest of the paths
    find_combinations(towels, design.slice(towel.length, design.length), path << towel, results)
  end

  results
end

towels = INPUT.split("\n\n").first.split(", ")
designs = INPUT.split("\n\n").last.each_line(chomp: true).to_a

good_designs = 0
designs.each { |design| good_designs += 1 unless find_combinations(towels, design).empty? }
p good_designs
