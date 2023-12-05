# frozen_string_literal: true

# INPUT = "Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
# Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
# Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
# Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
# Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
# Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11"

def winning_count(line)
  numbers = line.chomp.split(": ")[1].split(" | ").map { |n| n.scan(/\d+/) }
  numbers.last.count - (numbers.last - numbers.first).count
end

inputs = INPUT.each_line.map(&:chomp)

p1 = inputs.map do |line|
  winning_count = winning_count(line)
  2**(winning_count - 1) if winning_count.positive?
end.compact.reduce(:+)

pp p1

base = inputs.map { |line| [winning_count(line), 1] }

p2 = base.each_with_index do |card, index|
  card.last.times do
    next_index = index + 1
    card.first.times do
      break if next_index >= base.count

      base[next_index][1] += 1
      next_index += 1
    end
  end
end.map(&:last).reduce(:+)

pp p2
