# frozen_string_literal: true

data_file = File.join(File.dirname(__FILE__), "day_7_data.txt")
DATA = File.open(data_file).each_line.map { |line| line.chomp.split(" ") }

# rubocop:disable AbcSize,CyclomaticComplexity,MethodLength,PerceivedComplexity
def solve(answer_to_a, part_two)
  hash = {}
  done = []
  datum_index = 0
  while done.uniq.length < DATA.length
    current_step = DATA[datum_index]
    if current_step.length == 3
      if !current_step[0].match(/^[[:alpha:]]+$/)
        hash[current_step[2]] = current_step[0].to_i
        done.push(datum_index)
      elsif hash[current_step[0]]
        hash[current_step[2]] = hash[current_step[0]]
        done.push(datum_index)
      end
    elsif current_step.length == 4
      if hash[current_step[1]]
        hash[current_step[3]] = 65_536 + (~ hash[current_step[1]])
        done.push(datum_index)
      end
    elsif current_step.length == 5
      if (!current_step[0].match(/^[[:alpha:]]+$/) || hash[current_step[0]]) &&
         (!current_step[2].match(/^[[:alpha:]]+$/) || hash[current_step[2]])
        # rubocop:disable BlockNesting
        hash[current_step[4]] =
          if current_step[1] == "AND"
            if !current_step[0].match(/^[[:alpha:]]+$/)
              current_step[0].to_i & hash[current_step[2]]
            else
              hash[current_step[0]] & hash[current_step[2]]
            end
          elsif current_step[1] == "OR"
            hash[current_step[0]] | hash[current_step[2]]
          elsif current_step[1] == "LSHIFT"
            hash[current_step[0]] << current_step[2].to_i
          elsif current_step[1] == "RSHIFT"
            hash[current_step[0]] >> current_step[2].to_i
          end
        # rubocop:enable BlockNesting
        done.push(datum_index)
      end
    end
    # answer for part a
    hash["b"] = answer_to_a if part_two
    datum_index = datum_index < DATA.length - 1 ? datum_index + 1 : 0
  end

  hash["a"]
end
# rubocop:enable AbcSize,CyclomaticComplexity,MethodLength,PerceivedComplexity

part_a = solve(nil, false)
part_b = solve(part_a, true)

p part_a
p part_b
