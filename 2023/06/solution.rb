# frozen_string_literal: true

# TODO: i'm sure there's maths that would be better but this is stupid and brute force works

# INPUT = "Time:      7  15   30
# Distance:  9  40  200"

p1 = INPUT.each_line.map(&:split).transpose.drop(1).map do |line|
  time, distance = line.map(&:to_i)
  time.times.map { |t| (t * (time - t)) }.reject { |d| d <= distance }.count
end

pp p1.reduce(:*)

p2_time, p2_distance = INPUT.each_line.map { |l| l.split.drop(1).join.to_i }
p2 = p2_time.times.map { |t| (t * (p2_time - t)) }.reject { |d| d <= p2_distance }.count

pp p2
