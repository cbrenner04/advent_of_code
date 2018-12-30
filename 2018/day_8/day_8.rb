# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_8_data.txt")
data = File.read(data_file).chomp

# example
# data = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"

data = data.split(" ").map(&:to_i)

def metadata_total(data, totals)
  return if data.empty?
  number_of_children = data.shift
  number_of_metadata = data.shift
  number_of_children.times { metadata_total(data, totals) }
  metadata = data.shift(number_of_metadata)
  totals << metadata.sum
end

puts "Part one: #{metadata_total(data.dup, []).sum}"
