# frozen_string_literal: true

require_relative("../intcode.rb")

program = INPUT.split(",").map(&:to_i)
int_comp = Intcode.new(program)
output, = int_comp.run
p output
