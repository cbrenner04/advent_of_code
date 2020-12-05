# frozen_string_literal: true

require_relative("../intcode")

part_one, = Intcode.new(INPUT, 1, day_9: true).run
part_two, = Intcode.new(INPUT, 2, day_9: true).run

puts part_one
puts part_two
