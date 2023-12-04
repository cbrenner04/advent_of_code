# frozen_string_literal: true

def update_adjacent(x, y, l_octo_matrix, l_flashes, l_step_flashes)
  l_flashes += 1
  l_step_flashes.push([x, y])
  [[-1, -1], [-1, 0], [-1, 1], [0, 1], [1, 1], [1, 0], [1, -1], [0, -1]].each do |y_change, x_change|
    new_x = x + x_change
    new_y = y + y_change

    next if new_x.negative? || new_y.negative? || new_x >= 10 || new_y >= 10 # out of bounds

    l_octo_matrix[new_y][new_x] += 1

    if l_octo_matrix[new_y][new_x] > 9 && !l_step_flashes.include?([new_x, new_y])
      l_flashes, l_octo_matrix, l_step_flashes = update_adjacent(new_x, new_y, l_octo_matrix, l_flashes, l_step_flashes)
    end
  end

  [l_flashes, l_octo_matrix, l_step_flashes]
end

def check_and_update(l_octo_matrix, l_flashes)
  step_flashes = []
  10.times do |y|
    10.times do |x|
      next unless l_octo_matrix[y][x] > 9
      next if step_flashes.include?([x, y])

      l_flashes, l_octo_matrix, step_flashes = update_adjacent(x, y, l_octo_matrix, l_flashes, step_flashes)
    end
  end

  [l_flashes, l_octo_matrix, step_flashes]
end

octo_matrix = INPUT.each_line.map { |line| line.chomp.chars.map(&:to_i) }

flashes = 0
100.times do |_i|
  10.times { |y| 10.times { |x| octo_matrix[y][x] += 1 } }

  flashes, octo_matrix, step_flashes = check_and_update(octo_matrix, flashes)

  step_flashes.each { |x, y| octo_matrix[y][x] = 0 }
end

puts flashes

flashes = 0
step_flashes = []
step = 0
loop do
  step += 1
  10.times { |y| 10.times { |x| octo_matrix[y][x] += 1 } }

  flashes, octo_matrix, step_flashes = check_and_update(octo_matrix, flashes)

  break if step_flashes.count == 100

  step_flashes.each { |x, y| octo_matrix[y][x] = 0 }

  step_flashes = []
end

puts step + 100 # part two starts where part one left off
