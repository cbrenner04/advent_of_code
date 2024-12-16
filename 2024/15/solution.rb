# frozen_string_literal: true

require "matrix"

# INPUT = "########
# #..O.O.#
# ##@.O..#
# #...O..#
# #.#.O..#
# #...O..#
# #......#
# ########

# <^^>>>vv<v>>v<<"

# INPUT = "##########
# #..O..O.O#
# #......O.#
# #.OO..O.O#
# #..O@..O.#
# #O#..O...#
# #O..O..O.#
# #.OO.O.OO#
# #....O...#
# ##########

# <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
# vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
# ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
# <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
# ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
# ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
# >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
# <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
# ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
# v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^"

DIRECTIONS = {
  "<" => [0, -1],
  ">" => [0, 1],
  "^" => [-1, 0],
  "v" => [1, 0]
}

def can_i_move?(matrix, position)
  !position.first.negative? && !position.last.negative? &&
    position.first < matrix.row_count && position.last < matrix.column_count &&
    matrix[position.first, position.last] != "#"
end

def move_box(matrix, position, direction)
  next_position = [position.first + direction.first, position.last + direction.last]

  return matrix unless can_i_move?(matrix, next_position)

  prev_matrix = matrix

  if matrix[next_position.first, next_position.last] == "O"
    matrix = move_box(matrix, [next_position.first, next_position.last], direction)
  end

  return prev_matrix unless matrix[next_position.first, next_position.last] == "."

  matrix[next_position.first, next_position.last] = "O"
  matrix[position.first, position.last] = "."

  matrix
end

def move_the_boxes(matrix, moves, position)
  moves.each do |move|
    direction = DIRECTIONS[move]
    next_position = [position.first + direction.first, position.last + direction.last]

    next unless can_i_move?(matrix, next_position)

    matrix = move_box(matrix, next_position, direction) if matrix[next_position.first, next_position.last] == "O"

    next unless matrix[next_position.first, next_position.last] == "."

    matrix[next_position.first, next_position.last] = "@"
    matrix[position.first, position.last] = "."
    position = next_position
  end
  matrix
end

position = []
part_one_warehouse, moves = INPUT.split("\n\n")
# remove walls - first row, last row, first column, last column
part_one_warehouse = Matrix.rows(
  part_one_warehouse.each_line(chomp: true).each_with_index.map do |line, index|
    position = [index - 1, line.index("@") - 1] if line.include?("@")
    line.split("")[1..-2]
  end[1..-2]
)
moves = moves.each_line(chomp: true).map { |line| line.split("") }.flatten
part_one_warehouse = move_the_boxes(part_one_warehouse, moves, position)

part_one = part_one_warehouse.row_vectors.each_with_index.map do |row, row_index|
  row.each_with_index.map do |space, column_index|
    next unless space == "O"

    100 * (row_index + 1) + (column_index + 1)
  end.compact.reduce(:+)
end.compact.reduce(:+)

p part_one

part_two_warehouse = INPUT.split("\n\n").first.each_line(chomp: true).map { |line| line.split("") }

part_two_warehouse.each do |row|
  current_position = 0
  until current_position >= row.count
    space = row[current_position]

    case space
    when "O"
      row[current_position] = "["
      row.insert(current_position + 1, "]")
    when "@"
      row.insert(current_position + 1, ".")
    else
      row.insert(current_position + 1, space)
    end

    current_position += 2
  end
end

# part_two_warehouse = Matrix.rows(part_two_warehouse)
