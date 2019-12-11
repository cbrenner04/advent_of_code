# frozen_string_literal: true

asteroids = []

INPUT.each_line.with_index do |line, y|
  line.chomp.split("").each_with_index do |value, x|
    next unless value == "#"
    asteroids << [x, y]
  end
end

hit_angles = asteroids.map.with_index do |a, ai|
  hits = []
  asteroids.each_with_index do |b, bi|
    next if ai == bi
    x_diff = b[0] - a[0]
    y_diff = b[1] - a[1]
    # I was really struggling with getting the slopes right
    # My assumption is it had to do with float imprecision
    # found this https://stackoverflow.com/questions/42210889/calculate-angle-of-line-with-negative-slope
    angle = Math.atan2(x_diff, y_diff) / Math::PI
    distance = Math.sqrt((x_diff * x_diff) + (y_diff * y_diff))
    hits << { coords: b, angle: angle, distance: distance }
  end
  hits
end

hit_counts = hit_angles.map { |a| a.map { |h| h[:angle] }.uniq.count }
puts hit_counts.max

station_angles = hit_angles[hit_counts.find_index(hit_counts.max)]
grouped = station_angles.group_by { |g| g[:angle] }.sort.reverse
grouped.each { |group| group[1].sort_by! { |g| g[:distance] } }
two_hundredth_group = grouped[199]
two_hundredth_asteroid_coords = two_hundredth_group[1][0][:coords]
puts two_hundredth_asteroid_coords[0] * 100 + two_hundredth_asteroid_coords[1]
