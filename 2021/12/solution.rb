# frozen_string_literal: true

INPUT = "start-A
start-b
A-c
A-b
b-d
A-end
b-end"

data = INPUT.each_line.map(&:chomp).map { |path| path.split("-") }
starts = data.select { |d| d.include? "start" }
ends = data.select { |d| d.include? "end" }

p starts
p ends
