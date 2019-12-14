# frozen_string_literal: true

require_relative("../intcode.rb")

program = INPUT.split(",").map(&:to_i)
int_comp = Intcode.new(program)
output, = int_comp.run
count = 0
output.each_slice(3) do |set|
  tile_id = set[2]
  count += 1 if tile_id == 2
end
puts count
