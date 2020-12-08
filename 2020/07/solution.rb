# frozen_string_literal: true

data = INPUT.each_line.map(&:chomp)

# map bags
obj = {}
data.each do |datum|
  scanned = datum.scan(/(\d*\s?\w+\s\w+)\sbags?/).flatten
  scanned.delete(" no other") # this will then just be an empty object for the parent bag
  key = scanned.shift # parent bag
  obj[key] = {}
  # map the children with their counts
  scanned.each do |value|
    matched = value.match(/(\d+)\s(\w+\s\w+)/)
    color = matched[2]
    count = matched[1].to_i
    obj[key][color] = count
  end
end

PART_ONE = obj.dup

PART_ONE.delete("shiny gold") # don't care what goes in shiny gold for part one

seen = [] # bags that can contain shiny gold bags
leftover = [] # to catch any parent bags that are unrelated to shiny gold bags
until PART_ONE.keys == leftover # when whats left are bags that are unrelated, we're done
  keys = PART_ONE.keys

  next if keys.each do |key|
    PART_ONE[key].each_key do |color| # part one does not need the number of bags
      next unless seen.include?(color) || color == "shiny gold"

      seen << key
      PART_ONE.delete(key)
    end
    leftover = keys
  end
end

p seen.uniq.count

PART_TWO = obj.dup

def solve(color)
  return 1 if PART_TWO[color].empty?

  PART_TWO[color].keys.map { |k| solve(k) * PART_TWO[color][k] }.reduce(:+) + 1
end

p solve("shiny gold") - 1 # subtract the initial 1 for shiny gold
