# frozen_string_literal: true

require_relative("../intcode.rb")

def turn_north(current_panel)
  current_panel = [current_panel.first, current_panel.last + 1]
  [1, current_panel]
end

def turn_east(current_panel)
  current_panel = [current_panel.first + 1, current_panel.last]
  [2, current_panel]
end

def turn_south(current_panel)
  current_panel = [current_panel.first, current_panel.last - 1]
  [3, current_panel]
end

def turn_west(current_panel)
  current_panel = [current_panel.first - 1, current_panel.last]
  [4, current_panel]
end

def turn_left(facing, current_panel)
  if facing == 1
    turn_west(current_panel)
  elsif facing == 2
    turn_north(current_panel)
  elsif facing == 3
    turn_east(current_panel)
  elsif facing == 4
    turn_south(current_panel)
  end
end

def turn_right(facing, current_panel)
  if facing == 1
    turn_east(current_panel)
  elsif facing == 2
    turn_south(current_panel)
  elsif facing == 3
    turn_west(current_panel)
  elsif facing == 4
    turn_north(current_panel)
  end
end

def solve(part_two = false)
  program = INPUT.split(",").map(&:to_i)
  int_comp = Intcode.new(program)
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

panels = solve
puts panels.keys.count

panels = solve(true)
m = Array.new(6) { Array.new(50, 0) }

panels.keys.each do |key|
  x, y = key.split(",")
  y = y.to_i
  y = y.zero? ? 5 : y - 1
  m[y.to_i][x.to_i] = panels[key]
end

m.reverse.each { |row| puts row.map { |r| r.zero? ? " " : "#" }.join("") }
