# frozen_string_literal: true

# INPUT = "..@@.@@@@.
# @@@.@.@.@@
# @@@@@.@.@@
# @.@@@@..@.
# @@.@@@@.@@
# .@@@@@@@.@
# .@.@.@.@@@
# @.@@@.@@@@
# .@@@@@@@@.
# @.@.@@@.@."

def send_it(matrix, count, part_two = false)
  (0..matrix.first.length - 1).each do |x|
    (0..matrix.length - 1).each do |y|
      char = matrix[x][y]

      next if char == '.'

      surrounding = []

      unless x + 1 > matrix.first.length - 1
        surrounding.push(matrix[x + 1][y])
        unless y + 1 > matrix.length - 1
          surrounding.push(matrix[x + 1][y + 1])
        end
        unless (y - 1).negative?
          surrounding.push(matrix[x + 1][y - 1])
        end
      end

      unless (x - 1).negative?
        surrounding.push(matrix[x - 1][y])
        unless (y - 1).negative?
          surrounding.push(matrix[x - 1][y - 1])
        end
        unless y + 1 > matrix.length - 1
          surrounding.push(matrix[x - 1][y + 1])
        end
      end

      unless y + 1 > matrix.length - 1
        surrounding.push(matrix[x][y + 1])
      end

      unless (y - 1).negative?
        surrounding.push(matrix[x][y - 1])
      end

      if surrounding.count { |c| c == "@" } < 4
        count += 1
        matrix[x][y] = "." if part_two
      end
    end
  end
  return [count, matrix]
end

matrix = INPUT.each_line.map { |line| line.chomp.split("") }
part_one, = send_it(matrix.dup, 0)
part_two = 0
prev_part_two = nil
part_two_matrix = matrix.dup

loop do
  prev_part_two = part_two.dup
  part_two, part_two_matrix = send_it(part_two_matrix, part_two, true)
  break if part_two == prev_part_two
end

p part_one
p part_two
