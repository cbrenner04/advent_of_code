# frozen_string_literal: true

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
