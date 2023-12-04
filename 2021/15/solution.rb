# frozen_string_literal: true

INPUT = "1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581"

up = [0, -1]
right = [1, 0]
down = [0, 1]
left = [-1, 0]

matrix = INPUT.each_line.map { |line| line.chomp.chars.map(&:to_i) }
current_coord = [0, 0]
end_coord = [matrix.first.count - 1, matrix.count - 1]
until current_coord == end_coord

end
