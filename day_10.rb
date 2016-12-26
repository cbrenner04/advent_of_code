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
    instruction = data[instructions_index]
    if instruction[0..2] == "bot"
      inst_array = instruction.split
      first_hash = inst_array[5] == "bot" ? bots : outputs
      second_hash = inst_array[10] == "bot" ? bots : outputs
      bot = bots[inst_array[1]]
      if bot&.length == 2
        give_values(inst_array[6], bot.min, first_hash)
        give_values(inst_array[11], bot.max, second_hash)
        bots.delete(inst_array[1])
        done_instructions.push(instructions_index)
      end
    elsif instruction[0..4] == "value"
      inst_array = instruction.split
      value = inst_array[1]
      bot = inst_array[5]
      give_values(bot, value, bots)
      done_instructions.push(instructions_index)
    end
  end

  instructions_index = increment(instructions_index, data)
  break if bots.any? { |b| b[1] == %w(61 17) }
end
# rubocop:enable BlockNesting

p bots
