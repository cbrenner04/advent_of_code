# frozen_string_literal: true

def give_values(bot, value, bots)
  if bots[bot]
    bots[bot].push(value.to_i)
  else
    bots[bot] = [value.to_i]
  end
end

def increment(instructions_index, data)
  instructions_index < data.length - 1 ? instructions_index + 1 : 0
end

data = INPUT.each_line.map(&:chomp)

done_instructions = []
instructions_index = 0
bots = {}
outputs = {}

# rubocop:disable Metrics/BlockNesting
while done_instructions.length < data.length
  unless done_instructions.include?(instructions_index)
    instruction_array = data[instructions_index].split
    keyword = instruction_array[0]
    case keyword
    when "bot"
      bot_name = instruction_array[1]
      first_hash = instruction_array[5] == "bot" ? bots : outputs
      second_hash = instruction_array[10] == "bot" ? bots : outputs
      bot = bots[bot_name]
      if bot&.length == 2
        give_values(instruction_array[6], bot.min, first_hash)
        give_values(instruction_array[11], bot.max, second_hash)
        done_instructions.push(instructions_index)
      end
    when "value"
      value = instruction_array[1]
      bot = instruction_array[5]
      give_values(bot, value, bots)
      done_instructions.push(instructions_index)
    end
  end

  instructions_index = increment(instructions_index, data)
end
# rubocop:enable Metrics/BlockNesting

# Part 1
bots.each { |b| puts b[0] if b[1].sort == [17, 61] }

# Part 2
puts outputs.map { |o| o[1] if %w[0 1 2].include?(o[0]) }
            .compact
            .flatten
            .inject(1) { |acc, elem| acc * elem }
