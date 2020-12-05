# frozen_string_literal: true

require_relative("../intcode")
require_relative("./util")

int_comp = Intcode.new(INPUT)
# figured I do this first to not have to initialize the comp 2x
int_comp.instructions[0] = 2
output, opcode = int_comp.run
scaffolds = Scaffolds.new(output)
scaffolds.build
scaffolds.view

p scaffolds.coord_scores

scaffolds.map_path
instructions = scaffolds.path.join(",")
# https://www.reddit.com/r/adventofcode/comments/ebr7dg/2019_day_17_solutions/fb7ymcw/
matches = "#{instructions},"
          .match(/^(.{1,21})\1*(.{1,21})(?:\1|\2)*(.{1,21})(?:\1|\2|\3)*$/)

a = matches[1].gsub(/,$/, "")
b = matches[2].gsub(/,$/, "")
c = matches[3].gsub(/,$/, "")
main = instructions

[a, b, c].zip(%w[A B C]) { |substr, key| main = main.gsub(substr, key) }

main << "\n"

[a, b, c].each do |string|
  double_digits = string.scan(/(\d\d)/).flatten.uniq.map(&:to_i)
  double_digits.each { |int| string.gsub!(int.to_s, ("0".ord + int).chr) }
  string << "\n"
end

main = main.each_byte.map(&:ord)
a = a.each_byte.map(&:ord)
# b = b.each_byte.map(&:ord)
# c = c.each_byte.map(&:ord)
# continuous_feed = "y\n".each_byte.map(&:ord)
# not_continuous = "n\n".each_byte.map(&:ord)

# # should be able to do
# inputs = main.concat(a, b, c, not_continuous)
# inputs.each { |input| output, = int_comp.run(input) }
# puts output
# # but I am getting errors so I am doing this one at a time

main.each { |input| output, opcode = int_comp.run(input) }
view_output(output)
# First A input throws error "Expected R, L, or distance but got: 4373"
# my assumption is something is wrong with the Intcode. I am moving on for now
a.each do |input|
  puts "A: #{input}"
  output, opcode = int_comp.run(input)
  view_output(output)
end
p output
p opcode
