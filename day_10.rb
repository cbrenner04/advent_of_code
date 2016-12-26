# frozen_string_literal: true

# this is failing saying the value is too high, but it is curiously the correct
# answer for someone else's input.

def give_values(bot, value, bots)
  if bots[bot] && bots[bot].length < 2
    bots[bot].push(value)
  elsif !bots[bot]
    bots[bot] = [value]
  end
end

def increment(instructions_index, data)
  instructions_index < data.length - 1 ? instructions_index + 1 : 0
end

data = []
File.open("day_10_data.txt", "r") { |f| f.each_line { |l| data.push l[0..-2] } }

done_instructions = []
instructions_index = 0
bots = {}
outputs = {}

# rubocop:disable BlockNesting
while done_instructions.length < data.length
  unless done_instructions.include?(instructions_index)
    instruction_array = data[instructions_index].split
    keyword = instruction_array[0]
    if keyword == "bot"
      bot_name = instruction_array[1]
      first_hash = instruction_array[5] == "bot" ? bots : outputs
      second_hash = instruction_array[10] == "bot" ? bots : outputs
      bot = bots[bot_name]
      if bot&.length == 2
        give_values(instruction_array[6], bot.min, first_hash)
        give_values(instruction_array[11], bot.max, second_hash)
        done_instructions.push(instructions_index)
      end
    elsif keyword == "value"
      value = instruction_array[1]
      bot = instruction_array[5]
      give_values(bot, value, bots)
      done_instructions.push(instructions_index)
    end
  end

  instructions_index = increment(instructions_index, data)
  break if bots.any? { |b| b[1].sort == %w(17 61) }
end
# rubocop:enable BlockNesting

bots.each { |b| p b[0] if b[1].sort == %w(17 61) }
