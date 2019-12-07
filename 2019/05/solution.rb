# frozen_string_literal: true

require_relative("../intcode.rb")

data = INPUT.split(",").map(&:to_i)

intcode_computer = Intcode.new(data.dup, [1])
puts intcode_computer.run
intcode_computer = Intcode.new(data.dup, [5])
puts intcode_computer.run
