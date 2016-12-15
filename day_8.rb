data = []

File.open('day_8_data.txt', 'r') { |f| f.each_line { |l| data.push l[0..-2] } }

matrix = []

6.times do
  column = []
  50.times { column.push(false) }
  matrix.push(column)
end

data.each do |d|
  if d.include? 'rect'
    units = d.tr('rect ', '').split('x')
    x = units[0].to_i - 1
    y = units[1].to_i - 1
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
    p units
  elsif d.include? 'rotate column'
    units = d.tr('rotate column x=', '').tr(' ', '').tr(' ', '').tr('by', ',')
             .split(',').reject { |s| s == '' }
    p units
  else
    p 'nope'
  end
end

count = 0

matrix.each { |s| s.each { |a| count += 1 if a == true } }

p count
