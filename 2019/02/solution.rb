# frozen_string_literal: true

def run(program, noun, verb)
  program[1] = noun
  program[2] = verb
  instruction_pointer = 0
  instruction = program[instruction_pointer]

  until instruction == 99
    first_int = program[program[instruction_pointer + 1]]
    second_int = program[program[instruction_pointer + 2]]
    storage_location = program[instruction_pointer + 3]
    if instruction == 1
      program[storage_location] = first_int + second_int
    elsif instruction == 2
      program[storage_location] = first_int * second_int
    else
      raise "bad instruction"
    end
    instruction_pointer += 4
    instruction = program[instruction_pointer]
  end

  [program[0], noun, verb]
end

data = INPUT.split(",").map(&:to_i)

part_one, = run(data.dup, 12, 2)

puts part_one

noun = 0
verb = 0

catch :whatever do
  (0..99).each do |i|
    (0..99).each do |j|
      result, noun, verb = run(data.dup, i, j)
      throw :whatever if result == 19_690_720
    end
  end
end

puts 100 * noun + verb
