# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)

# rubocop:disable Metrics/MethodLength
def run(instructions)
  seen = []
  accumulator = 0
  current_instruction = 0
  until seen.include?(current_instruction) || current_instruction >= instructions.length
    seen << current_instruction

    op, value = instructions[current_instruction].split(" ")

    case op
    when "acc"
      accumulator += value.to_i
      current_instruction += 1
    when "jmp"
      current_instruction += value.to_i
    when "nop"
      current_instruction += 1
    end
  end
  [accumulator, current_instruction]
end
# rubocop:enable Metrics/MethodLength

p run(data)[0]

data.each_with_index do |datum, index|
  op, value = datum.split(" ")

  next if op == "acc"

  duper = data.dup

  duper[index] = op == "jmp" ? "nop #{value}" : "jmp #{value}"

  accumulator, current_instruction = run(duper)

  if current_instruction >= data.length
    p accumulator
    break
  end
end
