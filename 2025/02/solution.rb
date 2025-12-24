# frozen_string_literal: true

# INPUT = "11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124"

ids = INPUT.chomp.split(',').map { |i| i.split("-").map(&:to_i) }

part_one = []
part_two = []
ids.each do |l, r|
  (l..r).to_a.each do |d|
    d_as_string = d.to_s
    half_size = d_as_string.size / 2

    # part one
    a, b = d_as_string.partition(/.{#{half_size}}/)[1,2]
    part_one.push(d) if (b.to_i - a.to_i).zero? && a.size == b.size

    # part two
    (1..half_size).each do |c|
      arr = d_as_string.chars.each_slice(c).map(&:join)
      if arr.all? { |i| i == arr.first }
        part_two.push(d)
        next
      end
    end
  end
end

p part_one.reduce(&:+)
p part_two.uniq.reduce(&:+)
