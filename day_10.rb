def give_values(bot, value, bots)
  if bots[bot] && bots[bot].length < 2
    bots[bot].push(value)
  elsif !bots[bot]
    bots[bot] = [value]
  end
end

def increment(instructions_index, data)
  return instructions_index + 1 if instructions_index < data.length - 1
  0
end

data = []
File.open('day_10_data.txt', 'r') { |f| f.each_line { |l| data.push l[0..-2] } }

done_instructions = []
instructions_index = 0
bots = {}
outputs = {}

while done_instructions.length < data.length
  unless done_instructions.include?(instructions_index)
    instruction = data[instructions_index]
    if instruction[0..2] == 'bot'
      inst_array = instruction.split
      bot = bots[inst_array[1]]
      if bot&.length == 2
        if inst_array[5] == 'bot'
          give_values(inst_array[6], bot.min, bots)
        elsif inst_array[5] == 'outputs'
          give_values(inst_array[6], bot.min, outputs)
        end
        if inst_array[10] == 'bot'
          give_values(inst_array[11], bot.max, bots)
        elsif inst_array[10] == 'output'
          give_values(inst_array[11], bot.max, outputs)
        end
        bots.delete(inst_array[1])
        done_instructions.push(instructions_index)
      end
    elsif instruction[0..4] == 'value'
      inst_array = instruction.split
      value = inst_array[1]
      bot = inst_array[5]
      give_values(bot, value, bots)
      done_instructions.push(instructions_index)
    end
  end

  instructions_index = increment(instructions_index, data)
  results = []
  break if bots.any? { |b| b[1] == ['61', '17'] }
end

p bots
