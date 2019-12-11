# frozen_string_literal: true

# INPUT = ".#..##.###...#######\n##.############..##.\n.#.######.########.#\n.###.#######.####.#.\n#####.##.#.##.###.##\n..#####..#.#########\n####################\n#.####....###.#.#.##\n##.#################\n#####.##.###..####..\n..######..##.#######\n####.##.####...##..#\n.#####..#.######.###\n##...#.##########...\n#.##########.#######\n.####.#.###.###.#.##\n....##.##.###..#####\n.#.#.###########.###\n#.#.#.#####.####.###\n###.##.####.##.#..##"

asteroids = []

INPUT.each_line.with_index do |line, y|
  line.chomp.split("").each_with_index do |value, x|
    next unless value == "#"
    asteroids << [x, y]
  end
end

hit_angles = asteroids.map do |a|
  hits = []
  asteroids.each do |b|
    x_diff = b[0] - a[0]
    y_diff = b[1] - a[1]
    # I was really struggling with getting the slopes right
    # My assumption is it had to do with float imprecision
    # found this https://stackoverflow.com/questions/42210889/calculate-angle-of-line-with-negative-slope
    angle = Math.atan2(y_diff, x_diff) / (Math::PI / 180)
    distance = Math.sqrt((x_diff * x_diff) + (y_diff * y_diff))
    hits << { coords: b, angle: angle, distance: distance }
  end
  hits
end

part_one = hit_angles.map { |a| a.map { |h| h[:angle] }.uniq.count }
puts part_one.max
