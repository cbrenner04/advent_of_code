# frozen_string_literal: true

# INPUT = "7 6 4 2 1
# 1 2 7 8 9
# 9 7 6 2 1
# 1 3 2 4 5
# 8 6 4 4 1
# 1 3 6 7 9"

def good_report(report)
  return false unless report.sort.uniq == report || report.sort.reverse.uniq == report

  good = 0
  report.each_cons(2) do |num, next_num|
    good += 1 if (next_num > num ? next_num - num : num - next_num).between?(1, 3)
  end
  good == report.count - 1
end

inputs = INPUT.each_line.map { |line| line.split.map(&:to_i) }

# port one
p inputs.map { |report| good_report(report) }.count(true)

# part two
p inputs.map do |report|
  next true if good_report(report)

  (0..report.count).each_entry do |index|
    local_report = report.clone
    local_report.delete_at index
    break true if good_report(local_report)
  end
end.count(true)
