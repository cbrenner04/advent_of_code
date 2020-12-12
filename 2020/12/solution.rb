# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)

current_direction = "E"
current_coordinates = {
  "N" => 0,
  "S" => 0,
  "E" => 0,
  "W" => 0
}

data.each do |datum|
  action = datum[0]
  value = datum[1..].to_i

  if %w[L R].include?(action)
    case action
    when "R"
      directions = %w[S W N E]
      index = directions.find_index(current_direction)
      new_index = (index + (value / 90)) % 4
      current_direction = directions[new_index]
    when "L"
      directions = %w[N W S E]
      index = directions.find_index(current_direction)
      new_index = (index + (value / 90)) % 4
      current_direction = directions[new_index]
    else
      throw "how did you get here dummy?"
    end

    next
  end

  direction = action == "F" ? current_direction : action

  current_coordinates[direction] += value
end

p (current_coordinates["N"] - current_coordinates["S"]).abs + (current_coordinates["E"] - current_coordinates["W"]).abs

ship_coordinates = {
  "N" => 0,
  "S" => 0,
  "E" => 0,
  "W" => 0
}
waypoint = {
  "N" => 1,
  "S" => 0,
  "E" => 10,
  "W" => 0
}

data.each do |datum|
  action = datum[0]
  value = datum[1..].to_i

  if %w[L R].include?(action)
    case action
    when "R"
      directions = %w[S W N E]
      current_directions = waypoint.find_all { |_, v| v != 0 }
      new_waypoint = {
        "N" => 0,
        "S" => 0,
        "E" => 0,
        "W" => 0
      }
      current_directions.each do |direction, dv|
        index = directions.find_index(direction)
        new_index = (index + (value / 90)) % 4
        new_waypoint[directions[new_index]] = dv
      end
      waypoint = new_waypoint
    when "L"
      directions = %w[N W S E]
      current_directions = waypoint.find_all { |_, v| v != 0 }
      new_waypoint = {
        "N" => 0,
        "S" => 0,
        "E" => 0,
        "W" => 0
      }
      current_directions.each do |direction, dv|
        index = directions.find_index(direction)
        new_index = (index + (value / 90)) % 4
        new_waypoint[directions[new_index]] = dv
      end
      waypoint = new_waypoint
    else
      throw "how did you get here dummy?"
    end

    next
  end

  direction = action
  if action == "F"
    waypoint_directions = waypoint.find_all { |_k, v| v != 0 }
    waypoint_directions.each do |d, dv|
      ship_coordinates[d] += dv * value
    end

    next
  end

  waypoint[direction] += value
end

p (ship_coordinates["N"] - ship_coordinates["S"]).abs + (ship_coordinates["E"] - ship_coordinates["W"]).abs
