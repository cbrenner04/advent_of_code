# frozen_string_literal: true

require_relative("../intcode.rb")

program = INPUT.split(",").map(&:to_i)

int_comp = Intcode.new(program.dup, 1, true)
output, = int_comp.run
puts output
int_comp = Intcode.new(program.dup, 2, true)
output, = int_comp.run
puts output
