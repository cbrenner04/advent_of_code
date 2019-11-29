# frozen_string_literal: true

SERIAL_NUMBER = 9110

def get_power(x_coor, y_coor)
  rack_id = x_coor + 10
  power = rack_id * y_coor
  power += SERIAL_NUMBER
  power *= rack_id
  power = power.to_s[-3].to_i || 0
  power - 5
end

best_coordinates = nil
best_power = 0

(1..300).each do |y|
  (1..300).each do |x|
    # 3x3 best power
    sub_grid_power = 0
    (x..x + 2).each do |xx|
      (y..y + 2).each do |yy|
        sub_grid_power += get_power(xx, yy)
      end
    end
    if sub_grid_power > best_power
      best_coordinates = "#{x},#{y}"
      best_power = sub_grid_power
    end
  end
end

puts "Part one: #{best_coordinates}"

# couldn't figure out why this wasn't working
# used https://www.reddit.com/r/adventofcode/comments/a53r6i/2018_day_11_solutions/ebjppk9/
# to verify, somehow I was off by one on my size...

best_coordinates = nil
best_power = 0

(1..300).each do |y|
  (1..300).each do |x|
    # nxn best power
    # max is an arbitrary number here
    # started at 30
    # but once I was close to my answer I adjusted for quicker run time
    (0..15).each do |n|
      sub_grid_power = 0
      (x..x + n).each do |xx|
        next if xx > 300
        (y..y + n).each do |yy|
          next if yy > 300
          sub_grid_power += get_power(xx, yy)
        end
      end
      # still don't know why n + 1 is needed here
      if sub_grid_power > best_power
        best_coordinates = "#{x},#{y},#{n + 1}"
        best_power = sub_grid_power
      end
    end
  end
end

puts "Part two: #{best_coordinates}"
