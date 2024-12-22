# frozen_string_literal: true

# INPUT = "###############
# #...#...#.....#
# #.#.#.#.#.###.#
# #S#...#.#.#...#
# #######.#.#.###
# #######.#.#...#
# #######.#.###.#
# ###..E#...#...#
# ###.#######.###
# #...###...#...#
# #.#####.#.###.#
# #.#...#.#.#...#
# #.#.#.#.#.#.###
# #...#...#...###
# ###############"

def breadth_first_search(matrix, start_coords, end_coords, cheat_start = nil)
  directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]
  visited = Set.new
  queue = [[start_coords, 1]]

  until queue.empty?
    # looking to get the shortest path
    queue.sort_by! { |_, distance| distance }
    current, distance = queue.shift

    return distance if current == end_coords

    next if visited.include?(current)

    visited.add(current)

    directions.each do |direction|
      new_x = current.first + direction.first
      next if new_x.negative? || new_x >= matrix.first.count

      new_y = current.last + direction.last
      next if new_y.negative? || new_y >= matrix.count

      next if matrix[new_y][new_x] == "#" &&
              !(cheat_start && (cheat_start == distance || cheat_start + 1 == distance))

      queue << [[new_x, new_y], distance + 1]
    end
  end

  nil
end

start_coords = []
end_coords = []
matrix = INPUT.each_line(chomp: true).each_with_index.map do |line, index|
  chars = line.split("")
  chars.each_with_index do |char, char_i|
    case char
    when "S"
      start_coords = [char_i, index]
    when "E"
      end_coords = [char_i, index]
    end
  end
  chars
end

no_cheat_length = breadth_first_search(matrix, start_coords, end_coords)
cheats = (0..no_cheat_length).to_a.map do |cheat_start|
  breadth_first_search(matrix, start_coords, end_coords, cheat_start)
end
grouped = cheats.group_by { |distance| distance }
groups = grouped.keys
count_greater_than = 0
groups.sort.reverse.each do |group|
  count = grouped[group].count
  diff = no_cheat_length - group
  count_greater_than += count if diff > 100
  # # for example
  # count_greater_than += count if diff > 30
  # puts "There are #{count} cheats that save #{diff} picoseconds."
end
p count_greater_than # between 879 and 1881
