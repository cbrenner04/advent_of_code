# frozen_string_literal: true

require_relative("../intcode.rb")

data = INPUT.split(",").map(&:to_i)

intcode_computer = Intcode.new(data.dup)
intcode_computer.run
