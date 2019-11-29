# frozen_string_literal: true

Reindeer = Struct.new(:speed, :length, :rest)

INPUT =
  "Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
  Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds."

reindeer = []

INPUT.each_line do |line|
  speed, length, rest = line.chomp.scan(/(\d+)/)
  reindeer << Reindeer.new(speed, length, rest)
end

puts reindeer
