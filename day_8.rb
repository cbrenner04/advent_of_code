ROWS = 6
COLUMNS = 50

def update_index(index, offset, total)
  if index + offset > total - 1
    update_index((index + offset) - (total + offset), offset, total)
  else
    index + offset
  end
end

data = []

File.open('day_8_data.txt', 'r') { |f| f.each_line { |l| data.push l[0..-2] } }

matrix = []

ROWS.times do
  column = []
  COLUMNS.times { column.push(false) }
  matrix.push(column)
end

data.each do |d|
  if d.include? 'rect'
    units = d.tr('rect ', '').split('x')
    x = units[1].to_i - 1
    y = units[0].to_i - 1
    (0..x).each do |x_index|
      (0..y).each do |y_index|
        matrix[x_index][y_index] = if matrix[x_index][y_index] == false
                                     matrix[x_index][y_index] = true
                                   else
                                     matrix[x_index][y_index] = false
                                   end
      end
    end
  elsif d.include? 'rotate row'
    units = d.tr('rotate row y=', '').tr(' ', '').tr('by', ',').split(',')
    value_array = matrix[units[0].to_i].map(&:to_s)
    offset = units[1].to_i
    (0..COLUMNS - 1).each do |index|
      new_index = update_index(index, offset, COLUMNS)
      matrix[units[0].to_i][new_index] = (value_array[index] == 'true')
    end
  elsif d.include? 'rotate column'
    units = d.tr('rotate column x=', '').tr(' ', '').tr(' ', '').tr('by', ',')
             .split(',').reject { |s| s == '' }
    column_index = units[0].to_i
    value_array = matrix.each.map do |value|
      value[column_index]
    end
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

matrix.each { |s| s.map! { |a| a == true ? '*' : ' ' } }

matrix.each { |s| p s.join(',').tr(',', '') }
