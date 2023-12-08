# frozen_string_literal: true

# "Five of a kind", "Four of a kind", "Full house", "Three of a kind", "Two pair", "One pair", "High card"

INPUT = "32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483"

def all_indexes(array, item)
  array.each_index.select{ |i| array[i] == item }
end

cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]

hands = {}
INPUT.each_line do |line|
  hand, bid = line.chomp.split(" ")
  hands[hand] = {}
  hands[hand]["bid"] = bid.to_i
end

scores = hands.keys.map do |hand|
  hand_cards = hand.split("")
  counts = cards.map { |card| hand_cards.count(card) }
  case counts.max
  when 3
    counts.include?(2) ? 5 : 4
  when 5,  4
    counts.max + 2
  when 2
    counts.count(2) ? 3 : 2
  else
    counts.max
  end
end

rankers = (1..7).map { |score| all_indexes(scores, score) }

current_rank = 0
rankers.reverse.each do |ranks|
  current_rank += 1
  next if ranks.empty?

  if ranks.count > 1
    hand_cards = ranks.map { |rank| hands.keys[rank].split("").map { |card| cards.reverse.index(card) + 1 } }
    hand_ranks = (0..4).map { |i| hand_cards.map { |hand_card| hand_card[i] } }
    foo = []
    until foo.count >= ranks.count - 1
      hand_ranks.each do |hand_rank|
        how_many = hand_rank.count(hand_rank.max)
        next if how_many > 1

        foo << hand_rank.index(hand_rank.max)
      end
      pp foo
    end
  else
    hands[hands.keys[ranks.first]]["rank"] = current_rank
  end
end
