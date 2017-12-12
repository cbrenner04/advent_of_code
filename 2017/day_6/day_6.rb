# frozen_string_literal: true

states = []
count = 0
new_state = [5, 1, 10, 0, 1, 7, 13, 14, 3, 12, 8, 10, 7, 12, 0, 6]
while states.find_index(new_state).nil?
  state = Marshal.load(Marshal.dump(new_state))
  states << state
  count += 1
  max_value = new_state.max
  max_value_index = new_state.find_index(max_value)
  new_state[max_value_index] = 0
  index = max_value_index + 1
  index = 0 if index > new_state.length - 1
  until max_value.zero?
    new_state[index] += 1
    max_value -= 1
    index += 1
    index = 0 if index > new_state.length - 1
  end
end

p count

first_repeated_state = Marshal.load(Marshal.dump(new_state))
count = 0
indices_of_state = []
until indices_of_state.count > 2
  state = Marshal.load(Marshal.dump(new_state))
  states << state
  count += 1
  max_value = new_state.max
  max_value_index = new_state.find_index(max_value)
  new_state[max_value_index] = 0
  index = max_value_index + 1
  index = 0 if index > new_state.length - 1
  until max_value.zero?
    new_state[index] += 1
    max_value -= 1
    index += 1
    index = 0 if index > new_state.length - 1
  end
  indices_of_state =
    states.each_index.select { |i| states[i] == first_repeated_state }
end

p count - 1
