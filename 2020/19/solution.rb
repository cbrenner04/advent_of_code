# frozen_string_literal: true

# TODO: none of this works

input = "0: 4 1 5\n1: 2 3 | 3 2\n2: 4 4 | 5 5\n3: 4 5 | 5 4\n4: \"a\"\n5: \"b\"\n\nababbb\nbababa\nabbbab\naaabbb\naaaabbb"
rules, messages = input.split("\n\n").map { |substring| substring.each_line.map { |s| s.chomp.gsub(/"/, "") } }

rules_hash = {}
rules.each do |rule|
  key, value = rule.split(": ")
  value = value.include?("|") ? value.split(" | ") : value
  if value.is_a? Array
    value = value.map { |v| v.split.map(&:to_i) }
  elsif !value.scan(/\d/).empty?
    value = value.split.map(&:to_i)
  end
  rules_hash[key] = value
end

p rules_hash

# replace number with rule when rule is "complete"
# rule.scan(/\d/).empty? should give you rules that are "complete"

current_key = ""
current_value = ""

until rules_hash.keys.length == 1
  previous_key = current_key

  rules_hash.each do |key, value|
    next unless value.is_a?(String) || value.all? { |v| v.is_a? String }

    current_key = key.to_i
    current_value = value
    break
  end

  if previous_key == current_key
    rules_hash.each do |key, value|
      next unless value.flatten.all? { |v| v.is_a? String }

      new_value = if value.first.is_a? Array
                    value.map { |v| v.first.product(*v[1..]).map(&:join) }
                  else
                    value.first.product(*value[1..])
                  end
      rules_hash[key] = new_value
      current_key = key.to_i
      current_value = new_value
    end
  end

  break if previous_key == current_key

  rules_hash.each do |key, value|
    next if value.is_a? String

    new_value = if value.any? { |v| v.is_a? Array }
                  value.map do |v|
                    if v.is_a? Array
                      values = v.map { |vv| vv == current_key ? current_value : vv }
                      values.all? { |vv| vv.is_a? String } ? values.join : values
                    else
                      v
                    end
                  end
                else
                  values = value.map { |v| v == current_key ? current_value : v }
                  values
                end
    rules_hash[key] = new_value
  end

  rules_hash.delete(current_key.to_s)
  p rules_hash
end

values = rules_hash["0"]
values = values.map { |v| v.is_a?(String) ? [v] : v }
p values
values = values.first.product(*values[1..])
p values
