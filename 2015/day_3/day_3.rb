# frozen_string_literal: true
x = 0
y = 0
positions = [[0, 0]]

File.read("day_3_data.txt")[0..-2].each_char do |char|
  case char
  when "^"
    positions.push([x, y += 1])
  when "v"
    positions.push([x, y -= 1])
  when ">"
    positions.push([x += 1, y])
  when "<"
    positions.push([x -= 1, y])
  end
end

p positions.uniq.length
