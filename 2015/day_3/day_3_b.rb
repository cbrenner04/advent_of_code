# frozen_string_literal: true
# object for santa and his robot clone
Deliverer = Struct.new(:x, :y, :positions)

santa = Deliverer.new(0, 0, [[0, 0]])
robo_santa = Deliverer.new(0, 0, [[0, 0]])

File.read("day_3_data.txt")[0..-2].each_char.with_index do |char, index|
  object = index.even? ? santa : robo_santa
  case char
  when "^"
    object.positions.push([object.x, object.y += 1])
  when "v"
    object.positions.push([object.x, object.y -= 1])
  when ">"
    object.positions.push([object.x += 1, object.y])
  when "<"
    object.positions.push([object.x -= 1, object.y])
  end
end

p santa.positions.concat(robo_santa.positions).uniq.length
