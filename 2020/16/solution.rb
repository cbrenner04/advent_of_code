# frozen_string_literal: true

split_for_nearby = INPUT.split("\n\nnearby tickets:\n")
nearby_tickets = split_for_nearby.last.each_line.map { |line| line.chomp.split(",").map(&:to_i) }
split_for_fields = split_for_nearby.first.split("\n\nyour ticket:\n")
your_ticket = split_for_fields.last.chomp.split(",").map(&:to_i)
fields = {}
split_for_fields.first.each_line do |line|
  split_for_key = line.chomp.split(": ")
  key = split_for_key.first
  split_for_ranges = split_for_key.last.split(" or ")
  value_array = split_for_ranges.map do |range|
    min, max = range.split("-")
    (min.to_i..max.to_i).to_a
  end
  fields[key] = value_array
end

value_options = fields.values.flatten.uniq
part_one = nearby_tickets.flatten.map { |number| number unless value_options.include?(number) }.compact.reduce(:+)

puts part_one

good_nearby_tickets = nearby_tickets.map { |ticket| ticket if ticket.all? { |t| value_options.include? t } }.compact
remaining_fields = fields.keys
ordered_fields = []
index = 0
until ordered_fields.length == fields.keys.length
  remaining_fields.each do |key|
    next unless good_nearby_tickets.all? { |t| fields[key].flatten.include? t[index] }

    ordered_fields << key
    remaining_fields.delete(key)
    break
  end
  index += 1
end

# TODO: as far as i can tell from the example, this should work; runs too slow
part_two = ordered_fields.each_with_index.map { |f, fi| your_ticket[fi] if f.include?("departure") }.compact.reduce(:*)

puts part_two
