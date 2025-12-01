# frozen_string_literal: true

# INPUT = "125 17"

# def handle_rock_manipulation(rock)
#   rock_string = rock.to_s
#   rock_length = rock_string.length

#   if rock.zero?
#     1
#   elsif rock_length.even?
#     half_length = rock_length / 2
#     [rock_string[0, half_length].to_i, rock_string[half_length, half_length].to_i]
#   else
#     rock * 2024
#   end
# end

# rocks = INPUT.chomp.split.map(&:to_i)

# 25.times { rocks = rocks.map { |rock| handle_rock_manipulation(rock) }.flatten }

# p rocks.count

# # this will never finish in my lifetime
# 50.times { rocks = rocks.map { |rock| handle_rock_manipulation(rock) }.flatten }

# p rocks.count

# gpt'ed - much better data handling for a much faster running solution
# instead of transforming every stone and growing the list exponentially,
# aggregate counts and account for repetitive potterns
def handle_rock_transformation(freq)
  new_freq = Hash.new(0)

  freq.each do |rock, count|
    if rock.zero?
      new_freq[1] += count
    elsif rock.to_s.length.even?
      rock_str = rock.to_s
      half_len = rock_str.length / 2
      left = rock_str[0, half_len].to_i
      right = rock_str[half_len, half_len].to_i
      new_freq[left] += count
      new_freq[right] += count
    else
      new_freq[rock * 2024] += count
    end
  end

  new_freq
end

# Initial stone setup
rocks = INPUT.chomp.split.map(&:to_i)
freq = Hash.new(0)
rocks.each { |rock| freq[rock] += 1 }

# Simulate 25 blinks
25.times { freq = handle_rock_transformation(freq) }
p freq.values.sum

# Simulate 75 blinks
50.times { freq = handle_rock_transformation(freq) }
p freq.values.sum
