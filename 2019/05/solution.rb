# frozen_string_literal: true

require_relative("../intcode")

part_one, = Intcode.new(INPUT, 1).run
part_two, = Intcode.new(INPUT, 5).run

puts part_one
puts part_two
