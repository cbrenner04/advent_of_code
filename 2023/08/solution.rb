# frozen_string_literal: true

# INPUT = "RL

# AAA = (BBB, CCC)
# BBB = (DDD, EEE)
# CCC = (ZZZ, GGG)
# DDD = (DDD, DDD)
# EEE = (EEE, EEE)
# GGG = (GGG, GGG)
# ZZZ = (ZZZ, ZZZ)"

# INPUT = "LLR

# AAA = (BBB, BBB)
# BBB = (AAA, ZZZ)
# ZZZ = (ZZZ, ZZZ)"

# INPUT = "LR

# 11A = (11B, XXX)
# 11B = (XXX, 11Z)
# 11Z = (11B, XXX)
# 22A = (22B, XXX)
# 22B = (22C, 22C)
# 22C = (22Z, 22Z)
# 22Z = (22B, 22B)
# XXX = (XXX, XXX)"

instructions = INPUT.each_line.first.chomp.split("").map { |i| i == 'R' ? 1 : 0 }
last_instruction_index = instructions.count - 1
network = {}
a_nodes = []
INPUT.each_line.drop(2).each do |line|
  node, left_right = line.chomp.split(" = ")
  a_nodes << node if node[-1] == 'A'
  network[node] = left_right.scan(/\((\w+),\s(\w+)\)/).first
end

# p1
current_node = 'AAA'
current_instruction_index = 0
step = 0
loop do
  break if current_node == 'ZZZ'

  step += 1
  current_node = network[current_node][instructions[current_instruction_index]]
  current_instruction_index = (current_instruction_index >= last_instruction_index) ? 0 : current_instruction_index + 1
end

pp step

# p2
step = 0
current_instruction_index = 0
current_nodes = a_nodes
loop do
  break if current_nodes.all? { |current_node| current_node[-1] == 'Z' }

  step += 1
  next_nodes = []
  current_nodes = current_nodes.map { |current_node| network[current_node][instructions[current_instruction_index]] }
  current_instruction_index = (current_instruction_index >= last_instruction_index) ? 0 : current_instruction_index + 1
end

pp step
