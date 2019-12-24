# frozen_string_literal: true

# nanofactory that mines ore into fuel
class Nanofactory
  def initialize(reaction_list)
    @reactions = {}
    @ore = 0
    parse_reactions(reaction_list)
  end

  def run(amount)
    create_fuel("FUEL", amount)
  end

  private

  def parse_reactions(reaction_list)
    reaction_list.each_line do |line|
      inputs, output = line.chomp.split(" => ")
      output_amount, output_name = output.split(" ")
      input_hash = parse_inputs(inputs)
      @reactions[output_name] = {
        amount: output_amount.to_i,
        inputs: input_hash,
        output: 0
      }
    end
  end

  def parse_inputs(inputs)\
    input_hash = {}
    inputs.split(", ").each do |input|
      splits = input.split(" ")
      input_hash[splits.last] = splits.first.to_i
    end
    input_hash
  end

  def create_fuel(name, amount)
    reaction = @reactions[name]
    reaction_amount = reaction[:amount]
    multiplier = (amount.to_f / reaction_amount.to_f).ceil
    ore = run_reactions(reaction, multiplier)
    @reactions[name][:output] += multiplier * reaction_amount
    ore
  end

  # rubocop:disable AbcSize, MethodLength
  def run_reactions(reaction, multiplier)
    ore = 0
    reaction[:inputs].keys.each do |input_name|
      input_amount = multiplier * reaction[:inputs][input_name]
      if input_name == "ORE"
        ore += input_amount
        next
      end
      if @reactions[input_name][:output] < input_amount
        ore += create_fuel(input_name,
                           input_amount - @reactions[input_name][:output])
      end
      @reactions[input_name][:output] -= input_amount
    end
    ore
  end
  # rubocop:enable AbcSize, MethodLength
end
