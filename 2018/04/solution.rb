# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp).sort

guard_ids = data.map { |d| d.scan(/#(\d+)/)&.first&.first }.compact.uniq

counts_hash = {}
minutes_hash = {}

guard_ids.each do |id|
  counts_hash[id] = Array.new(60) { 0 }
  minutes_hash[id] = 0 # not strictly necessary
end

data.each_with_index do |d, i|
  asleep = d.scan("falls asleep")&.first
  next unless asleep
  awake = data[i + 1].scan("wakes up")&.first
  next unless awake
  guard_id = nil
  x = i
  x -= 1 until data[x].scan(/#(\d+)/)&.first&.first || x.zero?
  guard_id = data[x].scan(/#(\d+)/)&.first&.first
  start_sleep = d.scan(/:(\d\d)\]/)&.first&.first&.to_i
  end_sleep = data[i + 1].scan(/:(\d\d)\]/)&.first&.first&.to_i
  minutes_hash[guard_id] =
    (minutes_hash[guard_id] || 0) + (end_sleep - start_sleep)
  (start_sleep..end_sleep - 1).each { |n| counts_hash[guard_id][n] += 1 }
end

minutes_max = minutes_hash.max_by { |_, total| total }
guard_with_most_sleep = minutes_max.first
highest_count = counts_hash[guard_with_most_sleep].max
highest_count_index = counts_hash[guard_with_most_sleep].index(highest_count)

puts "Part one: #{guard_with_most_sleep.to_i * highest_count_index}"

count_max = counts_hash.max_by { |_, minutes_array| minutes_array.max }
guard_with_highest_minute_count = count_max.first
highest_count = counts_hash[guard_with_highest_minute_count].max
highest_count_index =
  counts_hash[guard_with_highest_minute_count].index(highest_count)

puts "Part two: #{guard_with_highest_minute_count.to_i * highest_count_index}"
