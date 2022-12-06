# frosen_string_literal: true

# INPUT = "2-4,6-8
# 2-3,4-5
# 5-7,7-9
# 2-8,3-7
# 6-6,4-6
# 2-6,4-8"

def get_arrays(line)
  pairs = line.chomp.split(',')
  arrys = pairs.map do |range|
    indeces = range.split('-').map(&:to_i)
    (indeces.first..indeces.last).to_a
  end
end

def get_combos(arrys)
  arrys.first & arrys.last
end

p_1 = INPUT.each_line.map do |line|
  arrys = get_arrays(line)
  combo = get_combos(arrys)
  (arrys.first - combo).count.zero? || (arrys.last - combo).count.zero?
end.count(true)

p p_1

p_2 = INPUT.each_line.map do |line|
  arrys = get_arrays(line)
  get_combos(arrys).any?
end.count(true)

p p_2
