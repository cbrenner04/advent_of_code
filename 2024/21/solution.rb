# frozen_string_literal: true

require "set"

NUMERIC_KEYPAD = [
  [7, 8, 9],
  [4, 5, 6],
  [1, 2, 3],
  [nil, 0, "A"]
].freeze

NUMERIC_KEYPAD_LOOKUP = {
  7 => [0, 0],
  8 => [1, 0],
  9 => [2, 0],
  4 => [0, 1],
  5 => [1, 1],
  6 => [2, 1],
  1 => [0, 2],
  2 => [1, 2],
  3 => [2, 2],
  0 => [1, 3],
  "A" => [2, 3]
}.freeze

DIRECTION_KEYPAD = [
  [nil, "^", "A"],
  ["<", "v", ">"]
].freeze

DIRECTION_KEYPAD_LOOKUP = {
  "^" => [1, 0],
  "A" => [2, 0],
  "<" => [0, 1],
  "v" => [1, 1],
  ">" => [2, 1]
}.freeze

# example
INPUT = "029A
980A
179A
456A
379A"

# # puzzle
# INPUT = "540A
# 839A
# 682A
# 826A
# 974A"

def search(char, previous_char, numeric = true)
  directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  direction_symbols = {
    [0, 1] => "v",
    [0, -1] => "^",
    [1, 0] => ">",
    [-1, 0] => "<"
  }
  matrix = numeric ? NUMERIC_KEYPAD : DIRECTION_KEYPAD
  start = numeric ? NUMERIC_KEYPAD_LOOKUP[char] : DIRECTION_KEYPAD_LOOKUP[char]
  end_coord = numeric ? NUMERIC_KEYPAD_LOOKUP[previous_char] : DIRECTION_KEYPAD_LOOKUP[previous_char]
  # queue == [current_position = [number, number], path = [number, number][], distance = number][]
  queue = [[start, [], 0]]
  visited = Set.new

  until queue.empty?
    queue.sort_by! { |_, _, distance| distance }
    current, path, distance = queue.shift

    return path if current == end_coord

    next if visited.include?(current)

    visited.add(current)

    directions.each do |direction|
      dir_char = direction_symbols[direction]

      new_x = current.first + direction.first
      next if new_x.negative? || new_x >= matrix.first.count

      new_y = current.last + direction.last
      next if new_y.negative? || new_y >= matrix.count

      queue << [[new_x, new_y], path + [dir_char], distance + 1]
    end
  end
end

# not quite right -> 272512 == too low
# same result whether these are nested maps or not
codes = INPUT.each_line(chomp: true).map { |line| line.split("").map { |char| char == "A" ? char : char.to_i } }
all_the_moves = codes.map do |code|
  previous_char = "A"
  level_one = code.map do |char|
    moves = search(previous_char, char)
    previous_char = char
    moves.append("A")
  end
  previous_char = "A"
  level_two = level_one.flatten.map do |char|
    moves = search(previous_char, char, false)
    previous_char = char
    moves.append("A")
  end
  previous_char = "A"
  full_path = level_two.flatten.map do |char|
    moves = search(previous_char, char, false)
    previous_char = char
    moves.append("A")
  end
  p full_path.flatten.join
  p full_path.flatten.count
  full_path.flatten.count * code[0..2].join.to_i
end

p all_the_moves.reduce(:+)
