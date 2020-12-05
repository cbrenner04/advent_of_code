# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)
register = {}
maxes = []

# need to initialize all the keys in the register
data.each { |datum| register[datum.split(" ").first] = 0 }

# rubocop:disable Style/CombinableLoops
data.each do |datum|
  split_datum = datum.split(" ")
  split_datum[0] = "register['#{split_datum.first}']"
  split_datum[1] = split_datum[1] == "inc" ? "+=" : "-="
  split_datum[4] = "register['#{split_datum[4]}']"
  # rubocop:disable Security/Eval
  eval(split_datum.join(" "))
  # rubocop:enable Security/Eval
  maxes << register.map { |_key, value| value }.max
end
# rubocop:enable Style/CombinableLoops

p maxes.last
p maxes.max
