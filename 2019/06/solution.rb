# frozen_string_literal: true

data = INPUT.split("\n")

orbiters = {}

data.each do |m|
  a, b = m.split(")")
  # need `.to_a` to create an array if `orbiters[a]` is nil
  parents = [a, orbiters[a].to_a].flatten
  orbiters[b] = parents
  orbiters.each { |k, v| orbiters[k].concat(parents) if v.include?(b) }
end

puts orbiters.values.flatten.count

diff_btwn_you_and_san = (orbiters["YOU"] - orbiters["SAN"]).count
diff_btwn_san_and_you = (orbiters["SAN"] - orbiters["YOU"]).count
puts diff_btwn_you_and_san + diff_btwn_san_and_you
