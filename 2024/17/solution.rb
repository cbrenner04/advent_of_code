# frozen_string_literal: true

# example - out: 4,6,3,5,6,3,5,2,1,0
INPUT = "Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0"

# example part two
INPUT = "Register A: 2024
Register B: 0
Register C: 0

Program: 0,3,5,4,3,0"

# puzzle (copied from input.txt)
INPUT = "Register A: 27334280
Register B: 0
Register C: 0

Program: 2,4,1,2,7,5,0,3,1,7,4,1,5,5,3,0"

def combo_operand(operand, registers)
  case operand
  when 0, 1, 2, 3
    operand
  when 4
    registers[:A]
  when 5
    registers[:B]
  when 6
    registers[:C]
  when 7
    throw "YOU SHOULDN'T BE HERE"
  end
end

registers = {}

INPUT.split("\n\n").first.each_line(chomp: true) do |line|
  match = line.match(/Register\s([ABC]):\s(\d+)/)
  registers[match[1].to_sym] = match[2].to_i
end

commands = INPUT.split("\n\n").last.split.last.split(",").map(&:to_i)

initial_a = registers[:A]
start = initial_a
output = []

# no chance this works for part 2
until output == commands
  part_one = start == initial_a
  registers[:A] = start
  output = []
  pointer = 0

  until pointer >= commands.count
    opcode = commands[pointer]
    operand = commands[pointer + 1]
    jump = false

    case opcode
    when 0
      registers[:A] = registers[:A] / (2**combo_operand(operand, registers))
    when 1
      registers[:B] = `echo $((#{registers[:B]} ^ #{operand}))`.chomp.to_i
    when 2
      registers[:B] = combo_operand(operand, registers) % 8
    when 3
      if registers[:A].zero?
        # noop
      else
        pointer = operand
        jump = true
      end
    when 4
      registers[:B] = `echo $((#{registers[:B]} ^ #{registers[:C]}))`.chomp.to_i
    when 5
      output << combo_operand(operand, registers) % 8
    when 6
      registers[:B] = registers[:A] / (2**combo_operand(operand, registers))
    when 7
      registers[:C] = registers[:A] / (2**combo_operand(operand, registers))
    end

    pointer += 2 unless jump
  end
  p output.join(",") if part_one
  p start if output == commands
  start += 1
end
