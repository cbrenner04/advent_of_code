# frozen_string_literal: true

DATA = INPUT.each_line.map { |line| line.chomp.split }

# rubocop:disable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity
def solve(answer_to_a, part_two)
  hash = {}
  done = []
  datum_index = 0
  while done.uniq.length < DATA.length
    current_step = DATA[datum_index]
    case current_step.length
    when 3
      if !current_step[0].match(/^[[:alpha:]]+$/)
        hash[current_step[2]] = current_step[0].to_i
        done.push(datum_index)
      elsif hash[current_step[0]]
        hash[current_step[2]] = hash[current_step[0]]
        done.push(datum_index)
      end
    when 4
      if hash[current_step[1]]
        hash[current_step[3]] = 65_536 + (~ hash[current_step[1]])
        done.push(datum_index)
      end
    when 5
      if (!current_step[0].match(/^[[:alpha:]]+$/) || hash[current_step[0]]) &&
         (!current_step[2].match(/^[[:alpha:]]+$/) || hash[current_step[2]])
        # rubocop:disable Metrics/BlockNesting
        hash[current_step[4]] =
          case current_step[1]
          when "AND"
            if current_step[0].match(/^[[:alpha:]]+$/)
              hash[current_step[0]] & hash[current_step[2]]
            else
              current_step[0].to_i & hash[current_step[2]]
            end
          when "OR"
            hash[current_step[0]] | hash[current_step[2]]
          when "LSHIFT"
            hash[current_step[0]] << current_step[2].to_i
          when "RSHIFT"
            hash[current_step[0]] >> current_step[2].to_i
          end
        # rubocop:enable Metrics/BlockNesting
        done.push(datum_index)
      end
    end
    # answer for part a
    hash["b"] = answer_to_a if part_two
    datum_index = datum_index < DATA.length - 1 ? datum_index + 1 : 0
  end

  hash["a"]
end
# rubocop:enable Metrics/AbcSize,Metrics/CyclomaticComplexity,Metrics/MethodLength,Metrics/PerceivedComplexity

part_a = solve(nil, false)
part_b = solve(part_a, true)

p part_a
p part_b
