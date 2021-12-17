# frozen_string_literal: true

dots, instructions = INPUT.split("\n\n").map { |a| a.split("\n") }
dot_coords = dots.map { |d| d.split(",").map(&:to_i) }
max_x = dot_coords.map(&:first).max
max_y = dot_coords.map(&:last).max
transparent_sheet = Array.new(max_y + 1) { Array.new(max_x + 1, ".") }
dot_coords.each { |x, y| transparent_sheet[y][x] = "#" }
instructions.each_with_index do |instruction, index|
  dir, line = instruction.scan(/fold along (x|y)=(\d+)/).first
  if dir == "x"
    transparent_sheet.each_with_index.map do |l, l_index|
      fold = l[line.to_i + 1..].reverse
      fold.each_with_index do |space, space_index|
        next unless space == "#"

        transparent_sheet[l_index][space_index] = "#"
      end
      transparent_sheet[l_index] = transparent_sheet[l_index][0..line.to_i - 1]
    end
  else
    fold = transparent_sheet[line.to_i + 1..].reverse
    transparent_sheet = transparent_sheet[0..line.to_i - 1]
    fold.each_with_index do |l, l_index|
      l.each_with_index do |space, space_index|
        next unless space == "#"

        transparent_sheet[l_index][space_index] = "#"
      end
    end
  end
  p transparent_sheet.map { |l| l.count("#") }.reduce(&:+) if index.zero?
end
# TODO: part two not quite correct
transparent_sheet.each { |l| puts l.join }
