# frozen_string_literal: true

ROWS = 6
COLUMNS = 50

def update_index(index, offset, total)
  if index + offset > total - 1
    update_index((index + offset) - (total + offset), offset, total)
  else
    index + offset
  end
end

def switch(value)
  value == false
end

data = INPUT.each_line.map(&:chomp)

matrix = Array.new(ROWS) { Array.new(COLUMNS, false) }

data.each do |d|
  if d.include? "rect"
    units = d.tr("rect ", "").split("x")
    x = units[1].to_i - 1
    y = units[0].to_i - 1
    (0..x).each { |j| (0..y).each { |k| matrix[j][k] = switch(matrix[j][k]) } }
  elsif d.include? "rotate row"
    units = d.tr("rotate row y=", "").tr(" ", "").tr("by", ",").split(",")
    value_array = matrix[units[0].to_i].map(&:to_s)
    offset = units[1].to_i
    (0..COLUMNS - 1).each do |index|
      new_index = update_index(index, offset, COLUMNS)
      matrix[units[0].to_i][new_index] = (value_array[index] == "true")
    end
  elsif d.include? "rotate column"
    units = d.tr("rotate column x=", "").tr(" ", "").tr(" ", "").tr("by", ",")
             .split(",").reject { |s| s == "" }
    column_index = units[0].to_i
    value_array = matrix.each.map { |value| value[column_index] }
    offset = units[1].to_i
    (0..ROWS - 1).each do |index|
      new_index = update_index(index, offset, ROWS)
      matrix[new_index][column_index] = value_array[index]
    end
  end
end

count = 0

matrix.each { |s| s.each { |a| count += 1 if a == true } }

p count

matrix.each do |s|
  s.map! { |a| a ? "*" : " " }
  p s.join(",").tr(",", "")
end
