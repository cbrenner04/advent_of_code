# frozen_string_literal: true

# intcode computer for days 2 and 5
class Intcode
  def initialize(instructions, initial_input = nil)
    @instructions = instructions
    @instruction_pointer = 0
    @inputs = initial_input ? [initial_input] : []
    @output = []
    @relative_base = 0
  end

  def instruction
    @instructions[@instruction_pointer]
  end

  def opcode
    instruction % 100
  end

  def allocate_more_mem(pointer)
    return unless @instructions.count < pointer
    (pointer + 1).times { @instructions.append(0) }
  end

  def first_param(modes_dont_matter = false)
    first = @instructions[@instruction_pointer + 1]
    return first if modes_dont_matter
    first_mode = (instruction / 100) % 10
    if first_mode.zero?
      allocate_more_mem(first)
      return @instructions[first]
    end
    return first if first_mode == 1
    raise "bad param mode" unless first_mode == 2
    pointer = relative_mode_param(first)
    allocate_more_mem(pointer)
    @instructions[pointer]
  end

  def second_param
    second = @instructions[@instruction_pointer + 2]
    second_mode = (instruction / 1000) % 10
    if second_mode.zero?
      allocate_more_mem(second)
      return @instructions[second]
    end
    return second if second_mode == 1
    raise "bad param mode" unless second_mode == 2
    pointer = relative_mode_param(second)
    allocate_more_mem(pointer)
    @instructions[pointer]
  end

  def third_param
    @instructions[@instruction_pointer + 3]
  end

  def relative_mode_param(param)
    @relative_base + param
  end

  def add_and_store
    @instructions[third_param] = first_param + second_param
    @instruction_pointer += 4
  end

  def multiply_and_store
    @instructions[third_param] = first_param * second_param
    @instruction_pointer += 4
  end

  def input_and_store
    throw :whatever if @inputs.empty?
    @instructions[first_param(true)] = @inputs.shift
    @instruction_pointer += 2
  end

  def output_param
    @output << first_param
    @instruction_pointer += 2
  end

  def jump_if_true
    if first_param.zero?
      @instruction_pointer += 3
      return
    end
    @instruction_pointer = second_param
  end

  def jump_if_false
    unless first_param.zero?
      @instruction_pointer += 3
      return
    end
    @instruction_pointer = second_param
  end

  def less_than
    @instructions[third_param] = first_param < second_param ? 1 : 0
    @instruction_pointer += 4
  end

  def equals
    @instructions[third_param] = first_param == second_param ? 1 : 0
    @instruction_pointer += 4
  end

  def adjust_relative_base
    @relative_base += first_param
    @instruction_pointer += 2
  end

  def run(new_input = nil)
    @inputs << new_input unless new_input.nil?
    @output = []
    # catching so i can throw in input_and_store if inputs are empty
    catch :whatever do
      loop do
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
        elsif opcode == 9
          adjust_relative_base
        elsif opcode == 99
          throw :whatever
        else
          raise "bad instruction"
        end
      end
    end
    output = @output.empty? ? @instructions.first : @output
    [output, opcode]
  end
end
