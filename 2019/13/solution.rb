# frozen_string_literal: true

require_relative("../intcode")
require_relative("./util")

int_comp = Intcode.new(INPUT)
int_comp.instructions[0] = 2
output, = int_comp.run
count, joystick = draw(output)
part_one = count
score = 0

while count.positive?
  int_comp = Intcode.new(int_comp.instructions.join(","))
  output, = int_comp.run(joystick)
  count, joystick, score = draw(output)
end

puts part_one
puts score
