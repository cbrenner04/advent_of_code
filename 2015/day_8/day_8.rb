# frozen_string_literal: true
data = File.open("day_8_data.txt", "r") { |f| f.each_line.map { |l| l[1..-3] } }
original_total = data.map(&:length).reduce(&:+)
p original_total
