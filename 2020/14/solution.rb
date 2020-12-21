# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)

zero_mask = ""
one_mask = ""
values = []

data.each do |datum|
  thing, value = datum.split(" = ")
  if thing == "mask"
    zero_mask = value.gsub("X", "0")
    one_mask = value.gsub("X", "1")
    next
  end

  binary = format("%036b", value) # takes value and returns 36 bits, 0 padded where necessary
  binary = format("%036b", eval("0b#{binary} | 0b#{zero_mask}").to_i) # flips 0 to 1
  binary = format("%036b", eval("0b#{binary} & 0b#{one_mask}").to_i) # flips 1 to 0

  index = thing.match(/mem\[(\d+)\]/)[1].to_i
  values.fill(0, values.length..index) if values.length < index
  values[index] = binary.to_i(2)
end

p values.reduce(:+)
