# frozen_string_literal: true

require_relative("../intcode.rb")

# INPUT = "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
# INPUT = "1102,34915192,34915192,7,4,7,99,0"
# INPUT = "104,1125899906842624,99"
program = INPUT.split(",").map(&:to_i)

int_comp = Intcode.new(program.dup, 1, true)
int_comp.run
# output, = int_comp.run
# puts output
