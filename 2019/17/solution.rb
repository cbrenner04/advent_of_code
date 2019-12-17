# frozen_string_literal: true

require_relative("../intcode.rb")

program = INPUT.split(",").map(&:to_i)
program[0] = 2
int_comp = Intcode.new(program)
output, = int_comp.run

matrix = output.map(&:chr).join("").split("\n").map { |r| r.split("") }

coord_scores = []

matrix.each_with_index do |row, ri|
  row.each_with_index do |cell, ci|
    if cell == "#" && matrix[ri - 1][ci] == "#" && matrix[ri + 1][ci] == "#" &&
       row[ci - 1] == "#" && row[ci + 1] == "#"
      coord_scores << ci * ri
    end
  end
end

p coord_scores.reduce(:+)
