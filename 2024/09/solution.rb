# frozen_string_literal: true

# INPUT = "2333133121414131402"
inputs = INPUT.chomp.split("").map(&:to_i)
new_inputs = []
non_empty_space_id = 0
inputs.each_with_index do |input, index|
  empty_space = index.odd?
  output = empty_space ? "." : non_empty_space_id
  input.times { |_| new_inputs << output }
  non_empty_space_id += 1 unless empty_space
end
empty_space_indexes = new_inputs.each_index.select { |i| new_inputs[i] == "." }
part_one = new_inputs.clone
part_one_empties_indexes = empty_space_indexes.clone

loop do
  break if part_one.count - 1 < part_one_empties_indexes.first

  input_to_move = part_one.pop

  next if input_to_move == "."

  new_input_index = part_one_empties_indexes.shift
  part_one[new_input_index] = input_to_move
end

part_one_product = 0
part_one.each_with_index do |f, i|
  break if f == "."

  part_one_product += f * i
end

p part_one_product

part_two = new_inputs.clone.slice_when { |a, b| a != b }.to_a
part_two_empties_indexes = part_two.each_index.select { |i| part_two[i].first == "." }
part_two_files_indexes = part_two.each_index.reject { |i| part_two[i].first == "." }

until part_two_files_indexes.empty?
  old_input_index = part_two_files_indexes.pop
  input = part_two[old_input_index]

  next if input.first == "."

  new_input_index = nil
  part_two_empties_indexes.each do |index|
    break if index >= old_input_index
    next if part_two[index].count < input.count

    new_input_index = index
    break
  end

  if new_input_index
    extras = part_two[new_input_index].count - input.count
    part_two[new_input_index] = input
    part_two[old_input_index] = []
    input.count.times { |_| part_two[old_input_index] << "." }
    if extras.positive?
      extras.times { |_| part_two[new_input_index] << "." }
      part_two_files_indexes = part_two_files_indexes.map do |i|
        new_input_index > i ? i : i + 1
      end
    end
  end

  part_two = part_two.flatten.slice_when { |a, b| a != b }.to_a
  part_two_empties_indexes = part_two.each_index.select { |i| part_two[i].first == "." }
end

part_two_product = 0
part_two.flatten.each_with_index do |f, i|
  next if f == "."

  part_two_product += f * i
end

p part_two_product
