# frozen_string_literal: true

def solve(coords, part_two = false)
  covered_coords = coords.map do |start, stop|
    start_x, start_y = start.split(",").map(&:to_i)
    stop_x, stop_y = stop.split(",").map(&:to_i)
    if start_x == stop_x
      set = start_y <= stop_y ? (start_y..stop_y) : (stop_y..start_y)
      set.to_a.map { |y| "#{start_x},#{y}" }
    elsif start_y == stop_y
      set = start_x <= stop_x ? (start_x..stop_x) : (stop_x..start_x)
      set.to_a.map { |x| "#{x},#{start_y}" }
    elsif part_two
      if start_y > stop_y && start_x > stop_x
        (stop_y..start_y).to_a.reverse.zip((stop_x..start_x).to_a.reverse).map { |y, x| "#{x},#{y}" }
      elsif start_y <= stop_y && start_x <= stop_x
        (start_y..stop_y).zip(start_x..stop_x).map { |y, x| "#{x},#{y}" }
      elsif start_y > stop_y && start_x <= stop_x
        (stop_y..start_y).to_a.reverse.zip(start_x..stop_x).map { |y, x| "#{x},#{y}" }
      elsif start_y <= stop_y && start_x > stop_x
        (start_y..stop_y).zip((stop_x..start_x).to_a.reverse).map { |y, x| "#{x},#{y}" }
      else
        throw "HOW DID YOU GET HERE?"
      end
    else
      next
    end
  end.flatten.compact
  covered_coords.group_by { |coord| coord }.select { |_k, group| group.size > 1 }.map(&:first).count
end

data = INPUT.each_line.map(&:chomp)
coords = data.map { |datum| datum.split(" -> ") }

p solve(coords)
p solve(coords, true)
