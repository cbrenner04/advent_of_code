# frozen_string_literal: true

# object for santa and his robot clone
Deliverer = Struct.new(:x, :y, :positions)

data_file = File.join(File.dirname(__FILE__), "day_3_data.txt")
DATA = File.read(data_file).chomp.each_char

# rubocop:disable AbcSize
def solve(part_two)
  santa = Deliverer.new(0, 0, [[0, 0]])
  robo_santa = Deliverer.new(0, 0, [[0, 0]])

  DATA.with_index do |char, index|
    object = index.odd? && part_two ? robo_santa : santa
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
