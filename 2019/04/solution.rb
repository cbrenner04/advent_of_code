# frozen_string_literal: true

# this is a pretty lame solution

def good_pass(pass, part_two = false)
  local_pass = pass.to_s
  good_length = local_pass.length == 6
  return false unless good_length
  has_double = local_pass.each_char.map.with_index do |char, i|
    next if i == local_pass.length - 1
    if part_two && local_pass[i + 1].to_i == char.to_i &&
       (local_pass[i - 1].to_i == char.to_i ||
        local_pass[i + 2].to_i == char.to_i)
      false
    else
      local_pass[i + 1].to_i == char.to_i
    end
  end.compact.any?(true)
  return false unless has_double
  has_descrease = local_pass.each_char.map.with_index do |char, i|
    next if i == local_pass.length - 1
    local_pass[i + 1].to_i >= char.to_i
  end.compact.any?(false)
  return false if has_descrease
  true
end

bounds = INPUT.split("-").map(&:to_i)
range = (bounds.first..bounds.last)

puts range.select { |pass| pass if good_pass(pass) }.length
puts range.select { |pass| pass if good_pass(pass, true) }.length
