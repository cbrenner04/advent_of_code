# frozen_string_literal: true

require_relative("../intcode")
require_relative("./util")

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def solve(part_two: false)
  int_comp = Intcode.new(INPUT)
  opcode = 0
  current_panel = [0, 0]
  panels = {}
  panels["0,0"] = 1 if part_two
  facing = 1
  until opcode == 99
    panel_name = "#{current_panel.first},#{current_panel.last}"
    panels[panel_name] = 0 unless panels[panel_name]
    outputs, opcode = int_comp.run(panels[panel_name])
    color, direction = outputs
    panels[panel_name] = color
    if direction.zero?
      facing, current_panel = turn_left(facing, current_panel)
    elsif direction == 1
      facing, current_panel = turn_right(facing, current_panel)
    end
  end
  panels
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

panels = solve(part_two: false)
puts panels.keys.count

panels = solve(part_two: true)
m = Array.new(6) { Array.new(50, 0) }

panels.each_key do |key|
  x, y = key.split(",")
  y = y.to_i
  y = y.zero? ? 5 : y - 1
  m[y.to_i][x.to_i] = panels[key]
end

m.reverse.each { |row| puts row.map { |r| r.zero? ? " " : "#" }.join("") }
