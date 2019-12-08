# frozen_string_literal: true

require_relative("../intcode.rb")

# part two examples
# INPUT = "3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5"
# INPUT = "3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10"

program = INPUT.split(",").map(&:to_i)

part_one_outputs = []

(0..4).to_a.permutation.each do |perm|
  int_comps = perm.map { |i| Intcode.new(program.dup, i) }
  input = 0
  int_comps.each { |ic| input, = ic.run(input) }
  part_one_outputs.append(input)
end

puts part_one_outputs.max

part_two_outputs = []

(5..9).to_a.permutation.each do |perm|
  int_comps = perm.map { |i| Intcode.new(program.dup, i) }
  input = 0
  index = 0
  loop do
    output, last_opcode = int_comps[index].run(input)
    input = output
    break if last_opcode == 99 && index == 4
    index == 4 ? index = 0 : index += 1
  end
  part_two_outputs.append(input)
end

# examples are correct
# 45964646 too high
puts part_two_outputs.max
