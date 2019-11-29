# frozen_string_literal: true

# bad implementation. as far as i can tell it works (works with one of the
# examples) but is so inefficient it throws stack errors which means you have to
# stop the recursion before it reaches that level, take the last password, and
# run it again. takes way too long with this process.

# turns out ruby has a method that does the incrementing exactly to spec: `succ`
# it's also much easier to let regex do the hard work

# abcdefgh -> abcdffaa
# ghijklmn -> ghjaabcc
# vzbxkghb ->

def alpha
  @alpha ||= ("a".."z").to_a.freeze
end

def chunk_is_straight?(chunk)
  first_index = alpha.find_index(chunk[0])
  second_index = alpha.find_index(chunk[1])
  third_index = alpha.find_index(chunk[2])
  return false unless first_index + 1 == second_index
  return false unless second_index + 1 == third_index

  true
end

def contains_straight?(password)
  len = password.length - 3
  straight = false
  (0..len).each do |i|
    chunk = password[i..i + 2]
    straight = chunk_is_straight?(chunk)
    break if straight
  end
  straight
end

def contains_forbidden_chars?(password)
  return true if password.index("i")
  return true if password.index("o")
  return true if password.index("l")

  false
end

def contains_two_pairs?(password)
  len = password.length - 2
  pairs = (0..len).map do |i|
    chunk = password[i..i + 1]
    chunk[0] == chunk[1]
  end
  pairs.join("") =~ /true.+true/
end

def good_password?(password)
  return false unless contains_straight?(password)
  return false if contains_forbidden_chars?(password)
  return false unless contains_two_pairs?(password)

  p "good password"
  true
end

def increment_char(char)
  next_char_index = alpha.find_index(char) + 1
  next_char_index >= alpha.length ? alpha[0] : alpha[next_char_index]
end

def increment_password(password)
  pwd_array = password.split("")
  current_index = pwd_array.length - 1
  while current_index >= 0
    new_char = increment_char(pwd_array[current_index])
    pwd_array[current_index] = new_char
    break if new_char != "a"

    current_index -= 1
  end
  pwd_array.join("")
end

def next_password(password, count = 0)
  new_password = increment_password(password)
  p new_password
  count += 1
  p count
  next_password(new_password, count) unless good_password?(new_password)
  new_password
end

p next_password("abcdefgh")
