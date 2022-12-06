# frozen_string_literal: true

# INPUT = "mjqjpqmgbljsphdztnvjfqwrcgsmlb" # 7, 19
# INPUT = "bvwbjplbgvbhsrlpgdmjqwftvncz" # 5, 23
# INPUT = "nppdvjthqldpwncqszvftbrmjlhg" # 6, 23
# INPUT = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg" # 10, 29
# INPUT = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw" # 11, 26

def find_it(string, size)
  (0..string.length).each do |i|
    next if i < size - 1
    if INPUT[(i - (size - 1))..i].split(//).uniq.count == size
      p i + 1
      break
    end
  end
end

find_it(INPUT, 4)
find_it(INPUT, 14)
