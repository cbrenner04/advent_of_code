# frozen_string_literal: true

# INPUT = "47|53
# 97|13
# 97|61
# 97|47
# 75|29
# 61|13
# 75|53
# 29|13
# 97|29
# 53|29
# 61|53
# 97|53
# 61|29
# 47|13
# 75|47
# 97|75
# 47|61
# 75|61
# 47|29
# 75|13
# 53|13

# 75,47,61,53,29
# 97,61,53,29,13
# 75,29,13
# 75,97,47,61,53
# 61,13,29
# 97,13,75,29,47"

inputs = INPUT.split("\n\n")
rules = {}
inputs.first.each_line do |rule|
  rs = rule.chomp.split("|")
  (rules[rs.first] ||= []) << rs.last
end

pages = inputs.last.split("\n")
correct_pages = pages.map do |page|
  split = page.chomp.split(",")
  correctness = split.each_with_index.flat_map do |p, i|
    second_pages = rules[p]
    next unless second_pages

    second_pages.map do |second_page|
      second_page_index = split.index(second_page)
      next unless second_page_index

      i < second_page_index
    end
  end
  correctness.compact.all?(true)
end

incorrect_pages = []
correct_middles = correct_pages.each_with_index.map do |correct, index|
  unless correct
    incorrect_pages << index
    next
  end
  l_pages = pages[index].split(",")
  l_pages[(l_pages.count / 2).ceil].to_i
end.compact

p correct_middles.reduce(:+)

part_two = incorrect_pages.map do |index|
  incorrect_page = pages[index].split(",")
  exhausted = false
  until exhausted
    l_ex = false
    incorrect_page.each_with_index do |p, j|
      second_pages = rules[p]
      next unless second_pages

      x_ex = second_pages.map do |sp|
        second_page_index = incorrect_page.index(sp)
        next unless second_page_index

        correct = second_page_index > j
        unless correct
          insert_index = j + 1 > incorrect_page.count ? incorrect_page.count : j + 1
          incorrect_page.insert(insert_index, sp)
          delete_index = insert_index < second_page_index ? second_page_index + 1 : second_page_index
          incorrect_page.delete_at(delete_index)
        end
        correct
      end.compact
      l_ex = x_ex.all?(true)
    end
    exhausted = l_ex
  end
  incorrect_page[incorrect_page.count / 2].to_i
end

p part_two.reduce(:+)
