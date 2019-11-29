# frozen_string_literal: true

# couldn't figure this one out
# got part one but wasn't coming close to part two
# this was likely due to poor implementation of part one
# below is pretty much copy/paste from
# https://github.com/petertseng/adventofcode-rb-2017/blob/master/07_balancing_discs.rb

own_weights = {}
children = {}

INPUT.each_line.map(&:chomp).each do |datum|
  name = datum.split.first
  datum_weight = datum[/\d+/].to_i
  datum_children =
    datum.include?("->") ? datum.split(" -> ").last.split(", ") : []
  own_weights[name] = datum_weight
  children[name] = datum_children
end

bottom = (own_weights.keys - children.values.flatten).first
puts bottom

total_weights = {}
total = ->(n) { total_weights[n] ||= own_weights[n] + children[n].sum(&total) }
_ = total[bottom]
total_weights.freeze

at = bottom
prev_weight = nil
until (weights = children[at].group_by(&total_weights)).size == 1
  singles = weights.select { |_, w| w.size == 1 }
  at = singles.values[0][0]
  prev_weight = (weights.keys - singles.keys).first
end

puts own_weights[at] - (total[at] - prev_weight)
