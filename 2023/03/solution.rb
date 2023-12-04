# frozen_string_literal: true

# TODO: I absolutely hate this solution

# INPUT = "467..114..
# ...*......
# ..35..633.
# ......#...
# 617*......
# .....+.58.
# ..592.....
# ......755.
# ...$.*....
# .664.598.."

def backward(line, char_i)
  # backward
  dig = []
  di = 1
  d = line[char_i - di]
  until d == "."
    dig.push d
    di += 1
    break if (char_i - di).negative?

    d = line[char_i - di]
  end
  dig.reverse
end

def forward(line, char_i, di = 1, dig = [])
  d = line[char_i + di]
  until d == "."
    dig.push d
    di += 1
    break if (char_i + di) >= line.length

    d = line[char_i + di]
  end
  dig
end

def backword_and_forward(line, char_i)
  di = 1
  d = line[char_i - di]
  until d == "."
    di += 1
    break if (char_i - di).negative?

    d = line[char_i - di]
  end
  di -= 1
  dig = []
  d = line[char_i - di]
  until di.zero?
    dig.push d
    di -= 1
    d = line[char_i - di]
  end
  forward(line, char_i, di, dig)
end

lines = INPUT.each_line.map(&:chomp)
spec_char = lines.map { |line| line.chomp.chars.map.with_index { |l, i| i if l.match(/[^\d.]/) }.compact }
gears = lines.map { |line| line.chomp.chars.map.with_index { |l, i| i if l.match(/\*/) }.compact }

p1 = spec_char.map.with_index do |chars, index|
  next unless chars.count.positive?

  chars.map do |c|
    prev_line = lines[index - 1].split("")
    curr_line = lines[index].split("")
    next_line = lines[index + 1].split("")
    digit = []
    prev_line_handled = false
    next_line_handled = false
    # if an adjacent char is a digit than traverse back to start or forward to finish of line and get the digits
    if prev_line[c].match(/\d/)
      digit.push backword_and_forward(prev_line, c)
      prev_line_handled = true
    end
    digit.push(backward(prev_line, c)) if prev_line[c - 1].match(/\d/) && !prev_line_handled
    digit.push(forward(prev_line, c)) if prev_line[c + 1].match(/\d/) && !prev_line_handled
    digit.push(backward(curr_line, c)) if curr_line[c - 1].match(/\d/)
    digit.push(forward(curr_line, c)) if curr_line[c + 1].match(/\d/)
    if next_line[c].match(/\d/)
      digit.push backword_and_forward(next_line, c)
      next_line_handled = true
    end
    digit.push(backward(next_line, c)) if next_line[c - 1].match(/\d/) && !next_line_handled
    digit.push(forward(next_line, c)) if next_line[c + 1].match(/\d/) && !next_line_handled

    digit.map { |a| a.join.to_i }
  end
end.compact.flatten.reduce(:+)

pp p1

p2 = gears.map.with_index do |gear_indeces, line_index|
  next unless gear_indeces.count.positive?

  part_numbers = gear_indeces.map do |gear_index|
    prev_line = lines[line_index - 1].split("")
    curr_line = lines[line_index].split("")
    next_line = lines[line_index + 1].split("")
    digit = []
    prev_line_handled = false
    next_line_handled = false
    # if an adjacent char is a digit than traverse back to start or forward to finish of line and get the digits
    if prev_line[gear_index].match(/\d/)
      digit.push backword_and_forward(prev_line, gear_index)
      prev_line_handled = true
    end
    digit.push(backward(prev_line, gear_index)) if prev_line[gear_index - 1].match(/\d/) && !prev_line_handled
    digit.push(forward(prev_line, gear_index)) if prev_line[gear_index + 1].match(/\d/) && !prev_line_handled
    digit.push(backward(curr_line, gear_index)) if curr_line[gear_index - 1].match(/\d/)
    digit.push(forward(curr_line, gear_index)) if curr_line[gear_index + 1].match(/\d/)
    if next_line[gear_index].match(/\d/)
      digit.push backword_and_forward(next_line, gear_index)
      next_line_handled = true
    end
    digit.push(backward(next_line, gear_index)) if next_line[gear_index - 1].match(/\d/) && !next_line_handled
    digit.push(forward(next_line, gear_index)) if next_line[gear_index + 1].match(/\d/) && !next_line_handled

    digit.map { |a| a.join.to_i } if digit.count > 1
  end.compact
  part_numbers.map { |first, second| first * second }
end.compact.flatten.reduce(:+)

pp p2
