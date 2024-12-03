# frozen_string_literal: true

# INPUT = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
# INPUT = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"

p1 = INPUT.scan(/mul\((\d+,\d+)\)/).flatten.map do |instruction|
  instruction.split(",").map(&:to_i).reduce(:*)
end.reduce(:+)

p p1

instructions = INPUT.scan(/((do|don't)\(\)|mul\(\d+,\d+\))/)
disabled = false

p2 = instructions.map do |instruction, conditional|
  if conditional
    disabled = conditional == "don't"
    next
  end

  next if disabled

  instruction.scan(/\d+/).map(&:to_i).reduce(:*)
end.compact.reduce(:+)

p p2
