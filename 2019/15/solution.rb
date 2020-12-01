# frozen_string_literal: true

require "set"
require_relative("../intcode")

# really struggled here. looked at a lot of solutions to realize the problem.
# i need to run the same state of the incode machine for checking the adjacent
# cells on each cell
X_CHANGES = [0, 0, -1, 1].freeze
Y_CHANGES = [-1, 1, 0, 0].freeze

Cell = Struct.new(:type, :distance, :instructions)

# adding the graph makes this run quite a bit slower
int_comp = Intcode.new(INPUT)
queue = Queue.new
matrix = Array.new(41) { Array.new(41) { Cell.new(nil, 0, nil) } }
starting_node = matrix[21][21]
starting_node.instructions = int_comp.instructions
starting_node.type = "O"
queue << [21, 21]
oxygen_system_distance = 0

until queue.empty?
  current = queue.pop
  current_pos = matrix[current.last][current.first]
  starting_instructions = current_pos.instructions
  (1..4).each_with_index do |direction, index|
    local_int_comp = Intcode.new(starting_instructions.join(","))
    next_y = current.last + Y_CHANGES[index]
    next_x = current.first + X_CHANGES[index]
    next_pos = matrix[next_y][next_x]
    next if next_pos.type # skip if its been visited

    output, = local_int_comp.run(direction)
    response, = output
    if response.zero?
      next_pos.type = "#"
      next
    end
    next_pos.type = "."
    if response == 2
      next_pos.type = "X"
      oxygen_system_distance = current_pos.distance + 1
    end
    next_pos.instructions = local_int_comp.instructions
    next_pos.distance = current_pos.distance + 1
    queue << [next_x, next_y]
  end
end

matrix.each { |row| puts row.map { |node| node.type || "#" }.join("") }
puts oxygen_system_distance
