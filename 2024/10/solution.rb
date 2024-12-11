# frozen_string_literal: true

require "matrix"

# INPUT = "89010123
# 78121874
# 87430965
# 96549874
# 45678903
# 32019012
# 01329801
# 10456732"

def get_valid_next_steps(matrix, starting_position, current_height)
  [[0, 1], [0, -1], [1, 0], [-1, 0]].map do |x, y|
    next_x = starting_position.first + x
    next_y = starting_position.last + y

    next nil if next_x.negative? || next_x >= matrix.row_count || next_y.negative? || next_y >= matrix.column_count

    next_height = matrix[next_x, next_y]
    next_height == (current_height + 1) ? [next_x, next_y] : nil
  end.compact
end

def traverse_trail(matrix, starting_position, peaks, count_peaks)
  current_height = matrix[starting_position.first, starting_position.last]

  if current_height == 9
    if count_peaks && !peaks.include?(starting_position)
      peaks << starting_position
      return 1
    elsif !count_peaks
      return 1
    end
  end

  valid_next_steps = get_valid_next_steps(matrix, starting_position, current_height)

  return 0 if valid_next_steps.empty?

  valid_next_steps.map { |next_step| traverse_trail(matrix, next_step, peaks, count_peaks) }.flatten.compact.reduce(:+)
end

matrix = Matrix.rows(INPUT.each_line(chomp: true).map { |line| line.split("").map(&:to_i) })
trail_heads = []
matrix.row_vectors.each_with_index do |vector, index|
  vector.each_with_index { |v, i| trail_heads << [index, i] if v.zero? }
end

p trail_heads.map { |trail_head| traverse_trail(matrix, trail_head, [], true) }.reduce(:+)
p trail_heads.map { |trail_head| traverse_trail(matrix, trail_head, [], false) }.reduce(:+)
