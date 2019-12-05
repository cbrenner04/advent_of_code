# frozen_string_literal: true

require_relative("../util.rb")

data = INPUT.split(",").map(&:to_i)
program = data.dup
program[1] = 12
program[2] = 2
part_one = run(program)

puts part_one

noun = 0
verb = 0

catch :whatever do
  (0..99).each do |i|
    (0..99).each do |j|
      program = data.dup
      noun = i
      verb = j
      program[1] = noun
      program[2] = verb
      result = run(program)
      throw :whatever if result == 19_690_720
    end
  end
end

puts 100 * noun + verb
