# again... hacked to hell, but it works so I'm moving on.

data = []

File.open('day_7_data.rb', 'r') { |f| f.each_line { |l| data.push l[0..-2] } }

count = 0

data.each_with_index do |string|
  array = []
  strings = string.split('[')
  strings.each { |str| array.push str.split(']') }
  array.flatten!
  length = array.length
  i = 0
  sub_strings = []
  until i >= length
    if i.even?
      new_string = array[i]
      place = 0
      string_length = new_string.length
      until place >= string_length
        if (new_string[place] == new_string[place + 2]) &&
           (new_string[place] != new_string[place + 1])
          sub_strings.push new_string[place..place + 2]
        end
        place += 1
      end
    end
    i += 1
  end

  next if sub_strings.empty?
  new_sub_strings = []
  sub_strings.each { |sub| new_sub_strings.push sub[1] + sub[0] + sub[1] }
  counted = false

  j = 1
  until j >= length
    if j.odd?
      new_string = array[j]
      new_sub_strings.each do |bab|
        if new_string.include? bab
          count += 1
          counted = true
          break
        end
      end
    end
    break if counted == true
    j += 1
  end
end

p count
