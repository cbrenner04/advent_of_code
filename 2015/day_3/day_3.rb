# frozen_string_literal: true
# object for santa and his robot clone
Deliverer = Struct.new(:x, :y, :positions)

# rubocop:disable AbcSize
def solve(part_two)
  santa = Deliverer.new(0, 0, [[0, 0]])
  robo_santa = Deliverer.new(0, 0, [[0, 0]])

  File.read("day_3_data.txt").chomp.each_char.with_index do |char, index|
    object = index.odd? && part_two == true ? robo_santa : santa
    update_position(char, object)
  end

  p santa.positions.concat(robo_santa.positions).uniq.length
end

def update_position(char, object)
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
# rubocop:enable AbcSize

solve(false)
solve(true)
