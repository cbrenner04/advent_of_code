# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)

# example
# data = [
#   "Step C must be finished before step A can begin.",
#   "Step C must be finished before step F can begin.",
#   "Step A must be finished before step B can begin.",
#   "Step A must be finished before step D can begin.",
#   "Step B must be finished before step E can begin.",
#   "Step D must be finished before step E can begin.",
#   "Step F must be finished before step E can begin."
# ]

parsed_data = data.map do |string|
  split_string = string.split
  [split_string[1], split_string[-3]]
end

instruction_hash = {}

parsed_data.each do |instructions|
  instruction_key = instructions.first
  instruction_value = instructions.last
  if instruction_hash[instruction_key]
    instruction_hash[instruction_key] << instruction_value
  else
    instruction_hash[instruction_key] = [instruction_value]
  end
end

# this seems to have no effect
instruction_hash.each { |_key, dependents| dependents.sort! }

part_one = instruction_hash.dup

# https://github.com/petertseng/adventofcode-rb-2018/blob/master/07_topological.rb
# only figured this out by getting the answer from the above code and seeing
# where my answer was different

alpha = [*"A".."Z"] # every letter is represented in the puzzle input
instruction_list = []

until part_one.length <= 1
  alpha.each do |char|
    # find the first letter (in alphabetical order) where it has no dependencies
    next unless part_one.each { |_k, v| break if v.any?(char) }

    # add that letter to the list
    instruction_list << char
    # remove dependents since its "finished"
    part_one.delete char
    # remove from alpha list
    alpha.delete char
    break
  end
end
# the above leaves that last dependent pair in the hash
leftover = part_one.first
instruction_list << leftover.first
instruction_list << leftover.last.first
puts "Part one: #{instruction_list.join}"
