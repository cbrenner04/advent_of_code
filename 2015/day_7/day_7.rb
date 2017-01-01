# frozen_string_literal: true

data = File.open("day_7_data.txt", "r") do |file|
  file.each_line.map { |line| line.chomp.split(" ") }
end
part_two = false
hash = {}
done = []
datum_index = 0
while done.uniq.length < data.length
  current_step = data[datum_index]
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
      done.push(datum_index)
    end
  end
  hash["b"] = 956 if part_two == true
  datum_index = datum_index < data.length - 1 ? datum_index + 1 : 0
end

p hash["a"]
