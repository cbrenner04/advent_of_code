# frozen_string_literal: true

INPUT = "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7"

# these are heinous, i hate them.

input = INPUT.split("\n\n")
numbers = input.shift.split(",").map(&:to_i)
boards = input.map { |i| i.split("\n").map { |j| j.split.map(&:to_i) } }

numbers.each do |number|
  break unless boards.each_with_index do |board, board_index|
    break unless board.each_with_index do |line, line_index|
      break unless line.each_with_index do |line_number, line_number_index|
        next unless line_number == number

        boards[board_index][line_index][line_number_index] = nil

        lines_out = boards.map { |lboard| lboard.any? { |lline| lline.compact.count.zero? } }
        columns = (0..4).map { |index| boards.map { |lboard| lboard.map { |lline| lline[index] } } }
        columns_out = columns.map { |fboard| fboard.any? { |fline| fline.compact.count.zero? } }
        next unless lines_out.any? || columns_out.any?

        puts boards[board_index].flatten.compact.reduce(:+) * number
        break
      end
    end
  end
end

# works for example but not real input
# this currently returns 17220 which is wrong
input = INPUT.split("\n\n")
numbers = input.shift.split(",").map(&:to_i)
boards = input.map { |i| i.split("\n").map { |j| j.split.map(&:to_i) } }
winners = []
lines_count = 0
columns_count = 0
numbers.each do |number|
  break unless boards.each_with_index do |board, board_index|
    break unless board.each_with_index do |line, line_index|
      break unless line.each_with_index do |line_number, line_number_index|
        next unless line_number == number

        boards[board_index][line_index][line_number_index] = nil

        lines_out = boards.map { |lboard| lboard.any? { |lline| lline.compact.count.zero? } }
        columns = (0..4).map { |index| boards.map { |lboard| lboard.map { |lline| lline[index] } } }
        columns_out = columns.map { |fboard| fboard.any? { |fline| fline.compact.count.zero? } }

        if lines_out.count(true) > lines_count
          lines_count = lines_out.count(true)
        elsif columns_out.count(true) > columns_count
          columns_count = columns_out.count(true)
        else
          next
        end

        winners.push(board_index) unless winners.include?(board_index)

        next unless boards.count == winners.count

        puts boards[board_index].flatten.compact.reduce(:+) * number
        break
      end
    end
  end
end
