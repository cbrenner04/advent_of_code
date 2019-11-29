# frozen_string_literal: false

def all_possible_straights
  @all_possible_straights ||= /abc|bcd|cde|def|efg|fgh|ghi|hij|ijk|jkl|klm|lmn|
                               mno|nop|opq|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz/
end

def good_password?(password)
  return false unless password[all_possible_straights]
  return false unless password !~ /[iol]/
  # \1 back references the first capture group and matches that text
  # \2 back references the second capture group and matches that text
  # https://ruby-doc.org/core-2.5.1/String.html#method-i-3D~
  # =~ returns the index where the match starts
  # if there aren't two matches then it returns nil
  return false if (password =~ /(.)\1.*(.)\2/).nil?

  true
end

password = "vzbxkghb"
# https://ruby-doc.org/core-2.5.1/String.html#method-i-succ
password.succ! until good_password?(password)
puts "Part one: #{password}"
password.succ!
password.succ! until good_password?(password)
puts "Part two: #{password}"
