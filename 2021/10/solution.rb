# frozen_string_literal: true

illegal_char_scores = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25_137
}

closing_char_scores = {
  ")" => 1,
  "]" => 2,
  "}" => 3,
  ">" => 4
}

closer = {
  "(" => ")",
  "[" => "]",
  "{" => "}",
  "<" => ">"
}

def corrupt?(opener, closer)
  bad_chars = {
    "(" => ["}", "]", ">"],
    "[" => ["}", ")", ">"],
    "{" => [")", "]", ">"],
    "<" => ["}", "]", ")"]
  }[opener]
  bad_chars.include?(closer)
end

def opener?(char)
  openers = ["(", "[", "{", "<"]
  openers.include?(char)
end

data = INPUT.each_line.map(&:chomp)
corrupt_indeces = []
corrupt_chars = data.each_with_index.map do |line, index|
  openers = []
  chars = line.chars
  current_char = ""
  chars.each do |char|
    current_char = char

    if opener?(current_char)
      openers.push(current_char)
      current_char = ""
      next
    end

    opener = openers.pop

    if corrupt?(opener, current_char)
      corrupt_indeces.push(index)
      break
    end

    current_char = ""
  end
  current_char
end

p corrupt_chars.reject(&:empty?).map { |char| illegal_char_scores[char] }.reduce(:+)

corrupt_indeces.reverse.each { |index| data.delete_at(index) }

closing_char_scores = data.map do |line|
  openers = []
  chars = line.chars
  chars.each do |char|
    if opener?(char)
      openers.push(char)
      next
    end

    opener = openers.pop

    next if closer[opener] == char
  end
  missing = openers.map { |opener| closer[opener] }.reverse
  score = 0
  missing.each { |missed| score = (score * 5) + closing_char_scores[missed] }
  score
end.sort

p closing_char_scores[(closing_char_scores.count / 2).ceil]
