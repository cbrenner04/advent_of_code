# frozen_string_literal: true

Reindeer = Struct.new(:name, :speed, :length, :rest, :points) do
  # rubocop:disable Metrics/MethodLength
  def distance_traveled(time)
    distance = 0
    while time.positive?
      fly_time = length
      while fly_time.positive?
        distance += speed
        time -= 1
        fly_time -= 1
        break if time.zero?
      end
      time -= rest
    end
    distance
  end
  # rubocop:enable Metrics/MethodLength
end

TOTAL_TIME = 2503

reindeer = []

INPUT.each_line do |line|
  name = line.chomp.scan(/^\w+/)[0]
  speed, length, rest = line.chomp.scan(/\d+/)
  reindeer << Reindeer.new(name, speed.to_i, length.to_i, rest.to_i, 0)
end

distances = reindeer.map do |deer|
  deer.distance_traveled(TOTAL_TIME)
end

puts distances.max

(1..TOTAL_TIME).to_a.each do |second|
  distance_groups = reindeer.group_by { |deer| deer.distance_traveled(second) }
  # `distance_groups.max` is an array where the first index is the distance and
  # the second index is the array of reindeer with that distance
  leaders = distance_groups.max[1]
  leaders.each { |leader| leader.points += 1 }
end

puts reindeer.map(&:points).max
