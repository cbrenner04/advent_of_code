# frozen_string_literal: true

def run(program)
  instruction_pointer = 0
  instruction = program[instruction_pointer]

  until instruction == 99
    if instruction == 1
      first_int = program[program[instruction_pointer + 1]]
      second_int = program[program[instruction_pointer + 2]]
      storage_location = program[instruction_pointer + 3]
      program[storage_location] = first_int + second_int
    elsif instruction == 2
      first_int = program[program[instruction_pointer + 1]]
      second_int = program[program[instruction_pointer + 2]]
      storage_location = program[instruction_pointer + 3]
      program[storage_location] = first_int * second_int
    elsif instruction == 3

    elsif instruction == 4

    else
      raise "bad instruction"
    end
    instruction_pointer += 4
    instruction = program[instruction_pointer]
  end

  program[0]
end
