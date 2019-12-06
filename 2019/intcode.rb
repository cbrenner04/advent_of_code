# frozen_string_literal: true

# intcode computer for days 2 and 5
class Intcode
  def initialize(instructions)
    @instructions = instructions
    @instruction_pointer = 0
  end

  def instruction
    @instructions[@instruction_pointer]
  end

  def opcode
    instruction % 100
  end

  def param_modes
    first_param_mode = (instruction / 100) % 10
    second_param_mode = (instruction / 1000) % 10
    third_param_mode = (instruction / 10_000) % 10
    [first_param_mode, second_param_mode, third_param_mode]
  end

  def first_param
    @instructions[@instruction_pointer + 1]
  end

  def second_param
    @instructions[@instruction_pointer + 2]
  end

  def third_param
    @instructions[@instruction_pointer + 3]
  end

  def add_and_store
    modes = param_modes
    first_int = modes.first.zero? ? @instructions[first_param] : first_param
    second_int = modes[1].zero? ? @instructions[second_param] : second_param
    @instructions[third_param] = first_int + second_int
    @instruction_pointer += 4
  end

  def multiply_and_store
    modes = param_modes
    first_int = modes.first.zero? ? @instructions[first_param] : first_param
    second_int = modes[1].zero? ? @instructions[second_param] : second_param
    @instructions[third_param] = first_int * second_int
    @instruction_pointer += 4
  end

  def input_and_store
    puts "ENTER INPUT:"
    input = gets.chomp
    @instructions[first_param] = input.to_i
    @instruction_pointer += 2
  end

  def output_param
    modes = param_modes
    puts modes.last.zero? ? @instructions[first_param] : first_param
    @instruction_pointer += 2
  end

  def jump_if_true
    modes = param_modes
    first_int = modes.first.zero? ? @instructions[first_param] : first_param
    if first_int.zero?
      @instruction_pointer += 3
      return
    end
    second_int = modes[1].zero? ? @instructions[second_param] : second_param
    @instruction_pointer = second_int
  end

  def jump_if_false
    modes = param_modes
    first_int = modes.first.zero? ? @instructions[first_param] : first_param
    unless first_int.zero?
      @instruction_pointer += 3
      return
    end
    second_int = modes[1].zero? ? @instructions[second_param] : second_param
    @instruction_pointer = second_int
  end

  def less_than
    modes = param_modes
    first_int = modes.first.zero? ? @instructions[first_param] : first_param
    second_int = modes[1].zero? ? @instructions[second_param] : second_param
    @instructions[third_param] = first_int < second_int ? 1 : 0
    @instruction_pointer += 4
  end

  def equals
    modes = param_modes
    first_int = modes.first.zero? ? @instructions[first_param] : first_param
    second_int = modes[1].zero? ? @instructions[second_param] : second_param
    @instructions[third_param] = first_int == second_int ? 1 : 0
    @instruction_pointer += 4
  end

  def run
    until opcode == 99
      if opcode == 1
        add_and_store
      elsif opcode == 2
        multiply_and_store
      elsif opcode == 3
        input_and_store
      elsif opcode == 4
        output_param
      elsif opcode == 5
        jump_if_true
      elsif opcode == 6
        jump_if_false
      elsif opcode == 7
        less_than
      elsif opcode == 8
        equals
      else
        raise "bad instruction"
      end
    end
    @instructions.first
  end
end
