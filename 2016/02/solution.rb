# frozen_string_literal: true

data = INPUT.each_line.map { |line| line.chomp.split("") }

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

STARTING_POSITION_1 = 5
VERTICAL_CHANGE_1 = 3
HORIZONTAL_CHANGE_1 = 1

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
    current_position - VERTICAL_CHANGE_1
  when "D"
    current_position + VERTICAL_CHANGE_1
  when "L"
    current_position - HORIZONTAL_CHANGE_1
  when "R"
    current_position + HORIZONTAL_CHANGE_1
  end
end

bathroom_code = data.map do |array|
  current_position = STARTING_POSITION_1
  array.each do |move|
    next if illegal_move?(current_position, move)
    current_position = make_move(current_position, move)
  end
  current_position
end.join("")

puts bathroom_code

#     1
#   2 3 4
# 5 6 7 8 9
#   A B C
#     D

options = %w[1 2 3 4 5 6 7 8 9 A B C D]

# unless index is 4, 1, 0, 3, 8 and move is up make move
# unless index is 4, 9, 12, 11, 8 and move is down make move
# unless index is 0, 3, 8, 11, 12 and move is right make move
# unless index is 0, 1, 4, 9, 12 and move is left make move

# if move is up and index is 2 or 12 subtract 2 else subtract 4
# if move is down and indes is 0 or 10 add 2 else add 4
# if move is left  subtract 1
# if move is right add 1

STARTING_POSITION_2 = 4
VERTICAL_CHANGE_2 = 4
ALT_VERTICAL_CHANGE = 2
HORIZONTAL_CHANGE_2 = 1

def illegal_up_2?(index, move)
  [0, 1, 3, 4, 8].include?(index) && move == "U"
end

def illegal_down_2?(index, move)
  [4, 8, 9, 11, 12].include?(index) && move == "D"
end

def illegal_right_2?(index, move)
  [0, 3, 8, 11, 12].include?(index) && move == "R"
end

def illegal_left_2?(index, move)
  [0, 1, 4, 9, 12].include?(index) && move == "L"
end

def illegal_move_2?(index, move)
  illegal_left_2?(index, move) ||
    illegal_right_2?(index, move) ||
    illegal_up_2?(index, move) ||
    illegal_down_2?(index, move)
end

# rubocop:disable CyclomaticComplexity, MethodLength
def make_move_2(index, move)
  case move
  when "U"
    change = [2, 12].include?(index) ? ALT_VERTICAL_CHANGE : VERTICAL_CHANGE_2
    index - change
  when "D"
    change = [0, 10].include?(index) ? ALT_VERTICAL_CHANGE : VERTICAL_CHANGE_2
    index + change
  when "L"
    index - HORIZONTAL_CHANGE_2
  when "R"
    index + HORIZONTAL_CHANGE_2
  end
end
# rubocop:enable CyclomaticComplexity, MethodLength

bathroom_code = data.map do |array|
  index = STARTING_POSITION_2
  array.each do |move|
    index = make_move_2(index, move) unless illegal_move_2?(index, move)
  end
  options[index]
end.join("")

puts bathroom_code
