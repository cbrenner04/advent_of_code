# frozen_string_literal: true

# need only the output values
p1_data = INPUT.each_line.map { |line| line.chomp.split(" | ")[1].split }.flatten

# starting with only trying to match 1, 4, 7, 8 as they have unique digits
# 1 == 2 (c, f)
# 4 == 4 (b, c, d, f)
# 7 == 3 (a, c, f)
# 8 == 7 (a, b, c, d, e, f, g)

# we just want a count of the outputs that match those digit counts
p p1_data.select { |output| [2, 3, 4, 7].include?(output.length) }.count

# need all values (10 for test, 200 for real)
data = INPUT.each_line.map { |line| line.chomp.split(" | ").map(&:split) }

output_value = []
data.each do |inputs, outputs|
  inputs.sort! { |a, b| a.length <=> b.length }
  # TODO: i bet i can do this in less steps
  # first using unique numbers we can get some possibilities and a single definite
  # comparing 1 (2 digits) and 7 (3 digits) will give you "a" as well as "c" and "f" possibiles (1)
  a_seg = (inputs[1].split("") - inputs.first.split(""))
  # comparing 1 (2 digits) with 4 (4 digits) will give you "b" and "d" possibilities
  bd = inputs[2].split("") - inputs.first.split("")
  # taking a and those possibilities to compare with 8 (7 digits) will give you "e" and "g" possibilities
  eg = inputs.last.split("") - bd.dup.concat(inputs.first.split("")).push(a_seg.first)

  # now what?
  # 0, 6, and 9 have 1 digit less than 8; "d", "c", and "e", respectively
  dce = inputs.select { |input| input.length == 6 }
              .map { |zsn| inputs.last.split("") - zsn.split("") }.flatten
  # get "b" and "f" from subtracting "d", "c", and "e" from "b", "d" and "c", "f"
  bf = bd.dup.concat(inputs.first.split("")) - dce
  # get "b" from subtracting "b", "f" from "c", "f"
  b_seg = bf - inputs.first.split("")
  # get "f" from subtracting "b" from "b", "f"
  f_seg = bf - b_seg
  # get "c" from subtracting "f" from "c", "f"
  c_seg = inputs.first.split("") - f_seg
  # get "d" from subtracting "d" from "b", "d"
  d_seg = bd - b_seg
  # get "e" from subtracting "d" and "c" from "d", "c", "e"
  e_seg = dce - d_seg - c_seg
  # get "g" from subtracting "e" from "e", "g"
  g_seg = eg - e_seg
  # 0: abcefg
  # 1: cf
  # 2: acdeg
  # 3: acdfg
  # 4: bcdf
  # 5: abdfg
  # 6: abdefg
  # 7: acf
  # 8: abcdefg
  # 9: abcdfg
  new_values = [
    [a_seg, b_seg, c_seg, e_seg, f_seg, g_seg].sort.join, # 0
    [c_seg, f_seg].sort.join, # 1
    [a_seg, c_seg, d_seg, e_seg, g_seg].sort.join, # 2
    [a_seg, c_seg, d_seg, f_seg, g_seg].sort.join, # 3
    [b_seg, c_seg, d_seg, f_seg].sort.join, # 4
    [a_seg, b_seg, d_seg, f_seg, g_seg].sort.join, # 5
    [a_seg, b_seg, d_seg, e_seg, f_seg, g_seg].sort.join, # 6
    [a_seg, c_seg, f_seg].sort.join, # 7
    [a_seg, b_seg, c_seg, d_seg, e_seg, f_seg, g_seg].sort.join, # 8
    [a_seg, b_seg, c_seg, d_seg, f_seg, g_seg].sort.join # 9
  ]
  # use above array to find values in outputs
  output_value.push(
    outputs.map { |output| new_values.find_index(output.split("").sort.join) }.join.to_i
  )
end

p output_value.reduce(:+)
