# frozen_string_literal: true

require_relative("../intcode")

intcode_comp = Intcode.new(INPUT)
intcode_comp.instructions[1] = 12
intcode_comp.instructions[2] = 2
part_one, = intcode_comp.run

puts part_one

noun = 0
verb = 0

catch :whatever do
  (0..99).each do |i|
    (0..99).each do |j|
      noun = i
      verb = j
      local_int_comp = Intcode.new(INPUT)
      local_int_comp.instructions[1] = noun
      local_int_comp.instructions[2] = verb
      result, = local_int_comp.run
      throw :whatever if result == 19_690_720
    end
  end
end

puts 100 * noun + verb
