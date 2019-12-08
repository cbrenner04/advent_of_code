# frozen_string_literal: true

require_relative("../intcode.rb")

data = INPUT.split(",").map(&:to_i)

intcode_computer = Intcode.new(data.dup, 1)
part_one, = intcode_computer.run
intcode_computer = Intcode.new(data.dup, 5)
part_two, = intcode_computer.run

puts part_one
puts part_two
