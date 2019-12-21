# frozen_string_literal: true

require_relative("../intcode.rb")

part_one_outputs = []

(0..4).to_a.permutation.each do |perm|
  int_comps = perm.map { |i| Intcode.new(INPUT, i) }
  input = 0
  int_comps.each do |ic|
    outputs, = ic.run(input)
    input = outputs.first
  end
  part_one_outputs.append(input)
end

puts part_one_outputs.max

part_two_outputs = []

(5..9).to_a.permutation.each do |perm|
  int_comps = perm.map { |i| Intcode.new(INPUT, i) }
  input = 0
  index = 0
  loop do
    outputs, last_opcode = int_comps[index].run(input)
    input = outputs.first
    break if last_opcode == 99 && index == 4
    index == 4 ? index = 0 : index += 1
  end
  part_two_outputs.append(input)
end

puts part_two_outputs.max
