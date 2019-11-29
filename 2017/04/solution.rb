# frozen_string_literal: true

data = INPUT.each_line.map { |line| line.chomp.split(" ") }

p data.select { |passphrase| passphrase.count == passphrase.uniq.count }.count

good_passphrases = data.select do |passphrase|
  new_arry = passphrase.map { |word| word.chars.sort.join }
  new_arry.count == new_arry.uniq.count
end

p good_passphrases.count
