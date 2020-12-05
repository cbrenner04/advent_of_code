# frozen_string_literal: true

def perform_bisection(ceiling, lower_indicator, indicators)
  range = [0, ceiling]

  indicators.each do |r|
    bisect = ((range[1] - range[0]) / 2).floor + range[0]
    if r == lower_indicator
      range[1] = bisect
    else
      range[0] = bisect + 1
    end
  end

  range.first
end

def find_row(rows)
  perform_bisection(127, "F", rows)
end

def find_column(columns)
  perform_bisection(7, "L", columns)
end
