# frozen_string_literal: true

# INPUT = "L68
# L30
# R48
# L5
# R60
# L55
# L1
# L99
# R14
# L82
# L652
# L1000
# R1000"

# 5919 < part_two < 6308

inputs = INPUT.each_line.map(&:chomp)
current_value = 50
part_one = 0
part_two = 0
inputs.each do |input|
  previous_value = current_value.dup
  puts "previous value: #{previous_value}"
  direction = input[0]
  puts "direction: #{direction}"
  length = input[1..-1].to_i
  puts "length: #{length}"
  current_value = (direction == "R" ? current_value + length : current_value - length)
  puts "current value: #{current_value}"
  next_value = current_value % 100
  puts "next value: #{next_value}"

  unless ((next_value.zero? || previous_value.zero?) && length < 100)
    puts "previous_value.zero?: #{previous_value.zero?}"
    passes_zero = (length / 100.0).floor
    if (
      !previous_value.zero? &&
      (
        (direction == "R" && ((length % 100) > (99 - previous_value))) ||
        (direction == "L" && ((length % 100) > previous_value))
      )
    )
      passes_zero += 1
      puts "added extra passes_zero value"
    end
    puts "passes zero: #{passes_zero}"
    part_two += passes_zero
  end

  current_value = next_value.dup
  if (current_value.zero?)
    part_one += 1
    part_two += 1
  end

  puts "part one: #{part_one}"
  puts "part two: #{part_two}"
  puts "\n\n"
end

p part_one
p part_two
