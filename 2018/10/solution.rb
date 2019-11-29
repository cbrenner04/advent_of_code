# frozen_string_literal: true

# Works with example but not real data
# real data takes too long and printing it is impossible to see

def update_coors(points)
  points.each do |pt|
    x = pt[:position][:x] + pt[:velocity][:x]
    y = pt[:position][:y] + pt[:velocity][:y]
    pt[:position][:x] = x
    pt[:position][:y] = y
  end
end

# data = INPUT.readlines

# example
data = [
  "position=< 9,  1> velocity=< 0,  2>",
  "position=< 7,  0> velocity=<-1,  0>",
  "position=< 3, -2> velocity=<-1,  1>",
  "position=< 6, 10> velocity=<-2, -1>",
  "position=< 2, -4> velocity=< 2,  2>",
  "position=<-6, 10> velocity=< 2, -2>",
  "position=< 1,  8> velocity=< 1, -1>",
  "position=< 1,  7> velocity=< 1,  0>",
  "position=<-3, 11> velocity=< 1, -2>",
  "position=< 7,  6> velocity=<-1, -1>",
  "position=<-2,  3> velocity=< 1,  0>",
  "position=<-4,  3> velocity=< 2,  0>",
  "position=<10, -3> velocity=<-1,  1>",
  "position=< 5, 11> velocity=< 1, -2>",
  "position=< 4,  7> velocity=< 0, -1>",
  "position=< 8, -2> velocity=< 0,  1>",
  "position=<15,  0> velocity=<-2,  0>",
  "position=< 1,  6> velocity=< 1,  0>",
  "position=< 8,  9> velocity=< 0, -1>",
  "position=< 3,  3> velocity=<-1,  1>",
  "position=< 0,  5> velocity=< 0, -1>",
  "position=<-2,  2> velocity=< 2,  0>",
  "position=< 5, -2> velocity=< 1,  2>",
  "position=< 1,  4> velocity=< 2,  1>",
  "position=<-2,  7> velocity=< 2, -2>",
  "position=< 3,  6> velocity=<-1, -1>",
  "position=< 5,  0> velocity=< 1,  0>",
  "position=<-6,  0> velocity=< 2,  0>",
  "position=< 5,  9> velocity=< 1, -2>",
  "position=<14,  7> velocity=<-2,  0>",
  "position=<-3,  6> velocity=< 2, -1>"
]

points = data.map do |datum|
  coors = datum.scan(/-?\d+/).map(&:to_i)
  {
    position: { x: coors[0], y: coors[1] },
    velocity: { x: coors[2], y: coors[3] }
  }
end

starting_x_coors = points.map { |pt| pt[:position][:x] }
starting_y_coors = points.map { |pt| pt[:position][:y] }
velocity_x_coors = points.map { |pt| pt[:velocity][:x] }
velocity_y_coors = points.map { |pt| pt[:velocity][:y] }
pos_min_x = starting_x_coors.min
pos_max_x = starting_x_coors.max
pos_min_y = starting_y_coors.min
pos_max_y = starting_y_coors.max
x_max = pos_min_x.abs + pos_max_x.abs
y_max = pos_min_y.abs + pos_max_y.abs
vel_x_max = velocity_x_coors.min.abs + velocity_x_coors.max.abs
vel_y_max = velocity_y_coors.min.abs + velocity_y_coors.max.abs
vel_max = [vel_x_max, vel_y_max].max

points.each do |pt|
  old_x = pt[:position][:x]
  old_y = pt[:position][:y]
  pt[:position][:x] = old_x + pos_min_x.abs
  pt[:position][:y] = old_y + pos_min_y.abs
end

# tried mapping to a matrix and printing that but that's super slow
# this is also very slow and is not readable with real data
(vel_max + 1).times do
  (0..y_max + 1).each do |y|
    row = []
    (0..x_max + 1).each do |x|
      sign = "."
      points.each do |pt|
        next unless pt[:position][:x] == x && pt[:position][:y] == y
        sign = "#"
      end
      row << sign
    end
    puts "#{row.join('')}\n"
  end
  update_coors(points)
  puts "\n\n"
end
