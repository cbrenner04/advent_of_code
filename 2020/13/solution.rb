# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)

timestamp = data.first.to_i
bus_ids = data.last.split(",").delete_if { |a| a == "x" }.map(&:to_i)

next_bus_times = {}
bus_ids.each { |id| next_bus_times[id] = (id - (timestamp % id)) + timestamp }

time_to_wait = next_bus_times.values.min
next_bus = next_bus_times.select { |_, v| v == time_to_wait }.keys.first

p (time_to_wait - timestamp) * next_bus
