# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)

part_one = data.dup
part_two = data.dup

count_two_letter_repeats = 0
count_three_letter_repeats = 0

part_one.each do |box_id|
  counted_chars = []
  already_counted_for_two = false
  already_counted_for_three = false
  box_id.split("").each do |char|
    next if counted_chars.include? char
    char_count = box_id.count(char)
    if char_count == 2 && !already_counted_for_two
      count_two_letter_repeats += 1
      already_counted_for_two = true
    elsif char_count == 3 && !already_counted_for_three
      count_three_letter_repeats += 1
      already_counted_for_three = true
    end
    counted_chars.push(char)
  end
end

puts "Part one: #{count_two_letter_repeats * count_three_letter_repeats}"

part_two.each_with_index do |outer_box_id, outer_index|
  outer_arry = outer_box_id.split("")
  break unless part_two.each_with_index do |inner_box_id, inner_index|
    next if inner_index == outer_index
    differing_chars_indexes = []
    inner_arry = inner_box_id.split("")
    outer_arry.each_with_index do |char, char_index|
      next if inner_arry[char_index] == char
      differing_chars_indexes.push(char_index)
      break if differing_chars_indexes.length > 1
    end
    next unless differing_chars_indexes.length == 1
    outer_arry.delete_at(differing_chars_indexes.first)
    puts "Part two: #{outer_arry.join('')}"
    break
  end
end
