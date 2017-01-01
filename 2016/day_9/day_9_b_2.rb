# frozen_string_literal: true
# rework from https://www.reddit.com/user/DeathWalrus

# rubocop:disable MethodLength, AbcSize
def decomp(string)
  i = 0
  total = 0
  while string && i < string.length
    if string[i] == "("
      i += 1
      new_string = ""
      while string[i] && string[i] != ")"
        new_string += string[i]
        i += 1
      end
      length = new_string.split("x")[0].to_i
      amount = new_string.split("x")[1].to_i
      total += amount * decomp(string[i + 1..i + length])
      i += length
    else
      total += 1
    end
    i += 1
  end
  total
end
# rubocop:enable MethodLength, AbcSize

p decomp(File.read("day_9_data.txt").chomp)
