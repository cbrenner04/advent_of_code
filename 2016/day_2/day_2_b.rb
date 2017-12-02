# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_2_data.txt")
data = File.open(data_file).each_line.map { |line| line.chomp.split("") }

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

STARTING_POSITION = 4
VERTICAL_CHANGE = 4
ALT_VERTICAL_CHANGE = 2
HORIZONTAL_CHANGE = 1

def illegal_up?(index, move)
  [0, 1, 3, 4, 8].include?(index) && move == "U"
end

def illegal_down?(index, move)
  [4, 8, 9, 11, 12].include?(index) && move == "D"
end

def illegal_right?(index, move)
  [0, 3, 8, 11, 12].include?(index) && move == "R"
end

def illegal_left?(index, move)
  [0, 1, 4, 9, 12].include?(index) && move == "L"
end

def illegal_move?(index, move)
  illegal_left?(index, move) ||
    illegal_right?(index, move) ||
    illegal_up?(index, move) ||
    illegal_down?(index, move)
end

# rubocop:disable CyclomaticComplexity, MethodLength
def make_move(index, move)
  case move
  when "U"
    change = [2, 12].include?(index) ? ALT_VERTICAL_CHANGE : VERTICAL_CHANGE
    index - change
  when "D"
    change = [0, 10].include?(index) ? ALT_VERTICAL_CHANGE : VERTICAL_CHANGE
    index + change
  when "L"
    index - HORIZONTAL_CHANGE
  when "R"
    index + HORIZONTAL_CHANGE
  end
end
# rubocop:enable CyclomaticComplexity, MethodLength

bathroom_code = data.map do |array|
  index = STARTING_POSITION
  array.each do |move|
    index = make_move(index, move) unless illegal_move?(index, move)
  end
  options[index]
end.join("")

p bathroom_code
