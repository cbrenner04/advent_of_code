# frozen_string_literal: true

# 2199943210
# 3987894921
# 9856789892
# 8767896789
# 9899965678

INPUT = "2199943210
3987894921
9856789892
8767896789
9899965678"

data = INPUT.each_line.map { |line| line.chomp.split("").map(&:to_i) }
low_points = []
data.each_with_index do |row, rindex|
  row.each_with_index do |height, hindex|
    adj_heights = []
    adj_heights.push(data[rindex - 1][hindex]) if data[rindex - 1] # up
    adj_heights.push(data[rindex][hindex - 1]) if data[rindex][hindex - 1] # left
    adj_heights.push(data[rindex][hindex + 1]) if data[rindex][hindex + 1] # right
    adj_heights.push(data[rindex + 1][hindex]) if data[rindex + 1] # down
    low_points.push({ height => [rindex, hindex] }) if height < adj_heights.min
  end
end

p low_points.map(&:keys).flatten.reduce(:+) + low_points.map(&:keys).count

# part two not working :(
@directions = {
  "up_left" => [-1, -1],
  "up" => [-1, 0],
  "up_right" => [-1, 1],
  "right" => [0, 1],
  "down_right" => [1, 1],
  "down" => [1, 0],
  "down_left" => [1, -1],
  "left" => [0, -1]
}

def move(direction, data, rindex, hindex, tracked, prev_value, basins)
  rindex_change, hindex_change = @directions[direction]
  rindex += rindex_change
  hindex += hindex_change

  return tracked if rindex.negative? || hindex.negative?
  return tracked unless data[rindex] && data[rindex][hindex]
  return tracked if tracked.include?([rindex, hindex]) || basins.any? { |basin| basin.include?([rindex, hindex]) }

  value = data[rindex][hindex]

  return tracked unless value > prev_value && value < 9

  tracked.push([rindex, hindex])

  move(direction, data, rindex, hindex, tracked, value, basins)
end

# need to work out from low point where the next adjacent point is
# greater than the previous, not 9, is not already attributed to a basin,
# and exists (otherwise terminate)
basins = []
until basins.count == 3
  lbasins = []
  low_points.each do |low_point|
    tracked = [low_point.values.first]

    tracked.each do |rindex, hindex|
      tracked = move("up", data, rindex, hindex, tracked, data[rindex][hindex], basins)
      tracked = move("right", data, rindex, hindex, tracked, data[rindex][hindex], basins)
      tracked = move("down", data, rindex, hindex, tracked, data[rindex][hindex], basins)
      tracked = move("left", data, rindex, hindex, tracked, data[rindex][hindex], basins)
      tracked = move("up_right", data, rindex, hindex, tracked, data[rindex][hindex], basins)
      tracked = move("up_left", data, rindex, hindex, tracked, data[rindex][hindex], basins)
      tracked = move("down_right", data, rindex, hindex, tracked, data[rindex][hindex], basins)
      tracked = move("down_left", data, rindex, hindex, tracked, data[rindex][hindex], basins)
    end

    lbasins.push(tracked)
  end
  basins.push(lbasins.min { |a, b| b.count <=> a.count })
end

p basins.map(&:count)
p basins.map(&:count).reduce(:*)
