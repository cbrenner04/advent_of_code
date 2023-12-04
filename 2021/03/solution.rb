# frozen_string_literal: true

def parse(data, part_2 = false)
  mapped = data.map(&:chars)
  foo = []

  mapped.each do |arry|
    arry.each_with_index do |value, index|
      foo[index] = [] unless foo[index]
      foo[index].push(value)
    end
  end

  # TODO: This can likely be simplified with bitwise operators
  foo.map do |f|
    count_1 = f.count("1")
    count_0 = f.count("0")
    if part_2
      count_0 > count_1 ? "0" : "1"
    else
      count_1 > count_0 ? "1" : "0"
    end
  end.join
end

data = INPUT.each_line.map(&:chomp)
gamma_binary = parse(data.dup)

gamma = gamma_binary.to_i(2)
# JFC ruby
epsilon = (gamma_binary.length - 1).downto(0).map { |n| (~gamma_binary.to_i(2))[n] }.join.to_i(2)

puts gamma * epsilon

ogr = data.dup
csr = data.dup
position = 0
until ogr.count == 1 && csr.count == 1
  ogr_parsed = parse(ogr, true)
  csr_parsed = parse(csr, true)
  unless ogr.count == 1
    current = ogr_parsed[position]
    ogr = ogr.select { |value| value[position] == current }.dup
  end
  unless csr.count == 1
    current = csr_parsed[position]
    csr = csr.reject { |value| value[position] == current }.dup
  end
  position += 1
end

puts ogr.first.to_i(2) * csr.first.to_i(2)
