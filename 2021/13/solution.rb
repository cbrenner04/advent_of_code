# frozen_string_literal: true

dots, instructions = INPUT.split("\n\n").map { |a| a.split("\n") }
dot_coords = dots.map { |d| d.split(",").map(&:to_i) }
max_x = dot_coords.map(&:first).max + 1
max_y = dot_coords.map(&:last).max + 1
transparent_sheet = Array.new(max_y) { Array.new(max_x, " ") }
dot_coords.each { |x, y| transparent_sheet[y][x] = "#" }

instructions.each_with_index do |instruction, index|
  # grab the direction of the fold and the line on which the fold takes place
  dir, line = instruction.scan(/fold along (x|y)=(\d+)/).flatten.compact
  if dir == "x"
    # iterate through each line of the sheet
    transparent_sheet.each_with_index do |_, l_index|
      # copy the line from the fold line plus 1 (fold line is dropped) and reverse
      fold = transparent_sheet[l_index][line.to_i + 1..].reverse
      # keep only the first part of the line from the fold line minus 1 (fold line is dropped) on the sheet
      transparent_sheet[l_index] = transparent_sheet[l_index][0..line.to_i - 1]
      # go through the reversed second part of the line and set the dots
      fold.each_with_index do |space, space_index|
        next unless space == "#"

        transparent_sheet[l_index][space_index] = "#"
      end
    end
  else
    # copy the bottom part of the sheet from the fold line plus 1 (fold line is dropped) and reverse
    fold = transparent_sheet[line.to_i + 1..].reverse
    # keep only the top part of the sheet from the fold line minus 1 (fold line is dropped)
    transparent_sheet = transparent_sheet[0..line.to_i - 1]
    # go through reversed bottom part and set dots
    fold.each_with_index do |l, l_index|
      l.each_with_index do |space, space_index|
        next unless space == "#"

        transparent_sheet[l_index][space_index] = "#"
      end
    end
  end
  # if this is the first pass, output the number of dots
  p transparent_sheet.map { |l| l.count("#") }.reduce(&:+) if index.zero?
end

# TODO: part two not quite correct
transparent_sheet.each { |l| puts l.join }
