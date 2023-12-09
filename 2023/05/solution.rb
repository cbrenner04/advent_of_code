# frozen_string_literal: true

# INPUT = "seeds: 79 14 55 13

# seed-to-soil map:
# 50 98 2
# 52 50 48

# soil-to-fertilizer map:
# 0 15 37
# 37 52 2
# 39 0 15

# fertilizer-to-water map:
# 49 53 8
# 0 11 42
# 42 0 7
# 57 7 4

# water-to-light map:
# 88 18 7
# 18 25 70

# light-to-temperature map:
# 45 77 23
# 81 45 19
# 68 64 13

# temperature-to-humidity map:
# 0 69 1
# 1 0 69

# humidity-to-location map:
# 60 56 37
# 56 93 4"

# https://stackoverflow.com/questions/39934266/check-if-two-ranges-overlap-in-ruby
def overlap?(values, range)
  range.begin <= values.max && values.min <= range.end
end

def solution(seeds)
  maps = {}
  current_map = nil
  current_source = nil
  source_values = []
  INPUT.each_line.drop(2).map(&:chomp).each do |line|
    next if line.empty?

    if line.include?("map")
      current_source = current_map || "seeds"
      current_map = line.match(/-(\w+) map:$/)[1]
      source_values = current_source == "seeds" ? seeds : maps[current_source].values
      next
    end

    destination_start, source_start, count = line.split.map(&:to_i)
    offset = destination_start - source_start
    destination_to_source = maps[current_map] || {}
    source_range = Range.new(source_start, source_start + count - 1)
    source_values.each_slice(10_000).with_index do |values, index|
      next unless overlap?(values, source_range)

      values.each { |v| destination_to_source[v] = v + offset if source_range.include?(v) }
    end
    leftovers = source_values - destination_to_source.keys
    leftovers.each { |leftover| destination_to_source[leftover] = leftover }
    maps[current_map] = destination_to_source
  end
  maps["location"].values.min
end

part_1_seeds = INPUT.each_line.first.scan(/\d+/).map(&:to_i)

pp solution(part_1_seeds)

part_2_seeds = []
current_index = 0
loop do
  break if current_index >= part_1_seeds.count - 1

  # TODO: this should be ranges not arrays - this will require an update to the solution
  part_2_seeds.concat (part_1_seeds[current_index]...part_1_seeds[current_index] + part_1_seeds[current_index + 1]).to_a
  current_index += 2
end

pp solution(part_2_seeds.sort)
