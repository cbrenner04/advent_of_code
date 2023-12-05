# frozen_string_literal: true

INPUT = "seeds: 79 14 55 13

seed-to-soil map:
50 98 2
52 50 48

soil-to-fertilizer map:
0 15 37
37 52 2
39 0 15

fertilizer-to-water map:
49 53 8
0 11 42
42 0 7
57 7 4

water-to-light map:
88 18 7
18 25 70

light-to-temperature map:
45 77 23
81 45 19
68 64 13

temperature-to-humidity map:
0 69 1
1 0 69

humidity-to-location map:
60 56 37
56 93 4"

seeds = INPUT.each_line.first.split(": ").last.split.map(&:to_i)
maps = {}
current_map = nil
current_source = nil
INPUT.each_line.drop(2).map(&:chomp).each do |line|
  next if line.empty?
  if line.include?('map')
    current_source = current_map || "seeds"
    current_map = line.split(" ").first.split("-").last
    next
  end

  source_values = current_source == "seeds" ? seeds : maps[current_source].values
  destination_start, source_start, count = line.split(" ").map(&:to_i)
  offset = destination_start - source_start
  destination_to_source = maps[current_map] ? maps[current_map] : {}
  source_range = (source_start..source_start + count - 1)
  source_values.each do |source_value|
    destination_to_source[source_value] = source_range === source_value ? source_value + offset : source_value
  end
  maps[current_map] = destination_to_source
end

pp maps
