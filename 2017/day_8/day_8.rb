# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_8_data.txt")
data = File.open(data_file).each_line.map(&:chomp)
register = {}
maxes = []

data.each { |datum| register[datum.split(" ").first] = 0 }

data.each do |datum|
  split_datum = datum.split(" ")
  split_datum[0] = "register['#{split_datum[0]}']"
  split_datum[1] = split_datum[1] == "inc" ? "+=" : "-="
  split_datum[4] = "register['#{split_datum[4]}']"
  eval(split_datum.join(" "))
  maxes << register.map { |_key, value| value }.max
end

p maxes.last
p maxes.max
