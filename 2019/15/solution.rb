# frozen_string_literal: true

require_relative("../intcode.rb")

program = INPUT.split(",").map(&:to_i)
int_comp = Intcode.new(program)
direction = 1
output = 0
# does not seem to stop
catch :whatever do
  loop do
    output, = int_comp.run(direction)
    if output.first.zero? && direction < 4
      direction += 1
    elsif output.first.zero? && direction >= 4
      direction = 1
    elsif output.first == 2
      throw :whatever
    end
  end
end
