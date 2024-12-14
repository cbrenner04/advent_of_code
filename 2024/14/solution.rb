# frozen_string_literal: true

require_relative "../../util"

# INPUT = "p=0,4 v=3,-3
# p=6,3 v=-1,-3
# p=10,3 v=-1,2
# p=2,0 v=2,-1
# p=0,0 v=1,3
# p=3,0 v=-2,-2
# p=7,6 v=-1,-3
# p=3,0 v=-1,-2
# p=9,3 v=2,3
# p=7,3 v=-1,2
# p=2,4 v=2,-3
# p=9,5 v=-3,-3"

# grid_x = 11
# grid_y = 7
# half_grid_x = 4
# half_grid_y = 2

grid_x = 101
grid_y = 103
half_grid_x = 49
half_grid_y = 50

# theres a better a way but i don't care
robots = INPUT.each_line(chomp: true).map do |robot|
  robot.scan(/p=(-?\d+,-?\d+)\sv=(-?\d+,-?\d+)/).first.map { |r| r.split(",").map(&:to_i) }
end

matrix = []

7_000.times do |i|
  robots.each_with_index do |robot, index|
    current_x, current_y = robot.first
    v_x, v_y = robot.last
    next_x = current_x + v_x
    next_y = current_y + v_y

    next_x -= grid_x if next_x >= grid_x
    next_x += grid_x if next_x.negative?
    next_y -= grid_y if next_y >= grid_y
    next_y += grid_y if next_y.negative?

    robots[index][0] = [next_x, next_y]
  end

  matrix = simple_matrix(grid_y, grid_x)

  robots.each do |robot|
    x, y = robot.first
    matrix[y][x] ? matrix[y][x] += 1 : matrix[y][x] = 1
  end

  if i == 99 # part 1; 100 - 1 due to 0 index
    upper_left = 0
    upper_right = 0
    (0..half_grid_y).each do |y|
      (0..half_grid_x).each { |x| upper_left += matrix[y][x] if matrix[y][x] }
      ((half_grid_x + 2)..grid_x - 1).each { |x| upper_right += matrix[y][x] if matrix[y][x] }
    end

    bottom_left = 0
    bottom_right = 0
    ((half_grid_y + 2)..grid_y - 1).each do |y|
      (0..half_grid_x).each { |x| bottom_left += matrix[y][x] if matrix[y][x] }
      ((half_grid_x + 2)..grid_x - 1).each { |x| bottom_right += matrix[y][x] if matrix[y][x] }
    end

    p upper_left * upper_right * bottom_left * bottom_right
  end

  matrix.each do |line| # 6771
    run = 0
    line.each do |l|
      if l
        run += 1
        puts i + 1 if run > 20 # part 2; add 1 due 0 index
      else
        run = 0
      end
    end
  end
end
