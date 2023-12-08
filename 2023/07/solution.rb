# frozen_string_literal: true

INPUT = "32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483"

def all_indexes(array, item)
  array.each_index.select { |i| array[i] == item }
end

cards = %w[A K Q J T 9 8 7 6 5 4 3 2]

hands = {}
INPUT.each_line do |line|
  hand, bid = line.chomp.split
  hands[hand] = {}
  hands[hand]["bid"] = bid.to_i
end

scores = hands.keys.map do |hand|
  hand_cards = hand.split("")
  counts = cards.map { |card| hand_cards.count(card) }

  case counts.max
  when 3
    counts.include?(2) ? 5 : 4
  when 5, 4
    counts.max + 2
  when 2
    counts.count(2) > 1 ? 3 : 2
  else
    counts.max
  end
end

rankers = (1..7).map { |score| all_indexes(scores, score) }

final_ranks = rankers.reverse.map do |ranks|
  next if ranks.empty?

  if ranks.count > 1
    hand_cards = ranks.map { |rank| hands.keys[rank].split("").map { |card| cards.reverse.index(card) + 1 } }
    hand_ranks = (0..4).map { |i| hand_cards.map { |hand_card| hand_card[i] } }
    hand_ranks.map { |hand_rank| all_indexes(hand_rank, hand_rank.max) }.flatten.uniq.map { |f| ranks[f] }
  else
    ranks.first
  end
end.compact

p1 = final_ranks.flatten.reverse.map.with_index do |rank, index|
  hands[hands.keys[rank]]["bid"] * (index + 1)
end.reduce(:+)

pp p1
