# frozen_string_literal: true

Distance = Struct.new(:start, :stop, :mileage)

data_file = File.join(File.dirname(__FILE__), "day_9_data.txt")
data = []
File.open(data_file).each_line.map do |line|
  start, _, stop, _, mileage = line.chomp.split(" ")
  data << Distance.new(start, stop, mileage.to_i)
  data << Distance.new(stop, start, mileage.to_i)
end

# adapted from https://github.com/gchan/advent-of-code-ruby/blob/master/2015/day-09/day-09-part-1.rb
# had no idea about `permutation` and `each_cons` --- super helpful

destinations = data.map { |d| [d.start, d.stop] }.flatten.uniq

totals = destinations.permutation.map do |path|
  path.each_cons(2).map do |start, stop|
    data.find { |d| d.start == start && d.stop == stop }.mileage
  end.reduce(&:+)
end

p totals.min
p totals.max
