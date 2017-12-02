# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_2_data.txt")
data = File.open(data_file).each_line.map { |line| line.chomp.split("") }

# 1 2 3
# 4 5 6
# 7 8 9

# start at 5
# U is up
# L is left
# R is right
# D is down

# unless current position is 1, 4, 7 and direction is L make move
# unless current position is 3, 6, 9 and direction is R make move
# unless current position is 1, 2, 3 and direction is U make move
# unless current position is 7, 8, 9 and direction is D make move

# if move is up -3 from current position
# if move is down +3 from current position
# if move is left -1 from current position
# if move is right +1 from current position

STARTING_POSITION = 5
VERTICAL_CHANGE = 3
HORIZONTAL_CHANGE = 1

def illegal_left?(current_position, move)
  [1, 4, 7].include?(current_position) && move == "L"
end

def illegal_right?(current_position, move)
  [3, 6, 9].include?(current_position) && move == "R"
end

def illegal_up?(current_position, move)
  [1, 2, 3].include?(current_position) && move == "U"
end

def illegal_down?(current_position, move)
  [7, 8, 9].include?(current_position) && move == "D"
end

def illegal_move?(current_position, move)
  illegal_left?(current_position, move) ||
    illegal_right?(current_position, move) ||
    illegal_up?(current_position, move) ||
    illegal_down?(current_position, move)
end

def make_move(current_position, move)
  case move
  when "U"
    current_position - VERTICAL_CHANGE
  when "D"
    current_position + VERTICAL_CHANGE
  when "L"
    current_position - HORIZONTAL_CHANGE
  when "R"
    current_position + HORIZONTAL_CHANGE
  end
end

bathroom_code = data.map do |array|
  current_position = STARTING_POSITION
  array.each do |move|
    next if illegal_move?(current_position, move)
    current_position = make_move(current_position, move)
  end
  current_position
end.join("")

p bathroom_code
