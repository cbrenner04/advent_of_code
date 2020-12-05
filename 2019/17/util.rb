# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/ClassLength, Metrics/BlockLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity, Naming/MethodParameterName
def view_output(output)
  if output.is_a?(Array)
    matrix = output.map do |char|
      begin
        char = char.chr
      rescue RangeError
        puts "RangeError"
      end
      char
    end
    matrix = matrix.join("").split("\n").map { |r| r.split("") }

    matrix.each { |m| puts m.join("") }
  else
    p output
  end
end

# scaffolds for the cleaning robot
class Scaffolds
  attr_reader :coord_scores, :starting_coords, :intersections, :path

  def initialize(ascii)
    # need to remove the last two lines as they are not part of the map
    @matrix =
      ascii.map(&:chr).join("").split("\n").map { |r| r.split("") }[0..-3]
    @coord_scores = []
    @starting_coords = []
    @intersections = []
    @path = []
  end

  def build
    coord_scores = []
    @matrix.each_with_index do |row, ri|
      next unless @matrix[ri + 1] && @matrix[ri - 1]

      row.each_with_index do |cell, ci|
        if intersection?(ri, ci)
          @intersections << "#{ri},#{ci}"
          coord_scores << ci * ri
        end
        @starting_coords = [ri, ci] if cell == "^"
      end
    end
    @coord_scores = coord_scores.reduce(:+)
  end

  def view
    @matrix.each { |m| puts m.join("") }
  end

  def map_path
    ri = @starting_coords[0]
    ci = @starting_coords[1]

    loop do
      direction = map_direction(@matrix[ri][ci])
      left_of_cell = @matrix[ri] ? @matrix[ri][ci - 1] : "."
      right_of_cell = @matrix[ri] ? @matrix[ri][ci + 1] : "."
      above_cell = @matrix[ri - 1] ? @matrix[ri - 1][ci] : "."
      below_cell = @matrix[ri + 1] ? @matrix[ri + 1][ci] : "."
      break if [left_of_cell, right_of_cell, above_cell, below_cell].all? "."

      current_dir = next_dir(direction, left_of_cell, right_of_cell,
                             above_cell, below_cell)
      ri, ci, current_count = find_next_turn(ri, ci, direction, current_dir)
      @path << "#{current_dir},#{current_count}"
      turn(ri, ci, direction, current_dir)
    end
  end

  private

  def intersection?(ri, ci)
    @matrix[ri][ci] == "#" && @matrix[ri - 1][ci] == "#" &&
      @matrix[ri + 1][ci] == "#" && @matrix[ri][ci - 1] == "#" &&
      @matrix[ri][ci + 1] == "#"
  end

  # 1 == north, 2 == east, 3 == south, 4 == west
  def map_direction(cell)
    { "^" => 1, ">" => 2, "v" => 3, "<" => 4 }[cell]
  end

  def find_next_turn(ri, ci, direction, current_dir)
    current_count = 0
    cell = "#"
    loop do
      @matrix[ri][ci] = "." unless @intersections.include?("#{ri},#{ci}")
      case current_dir
      when "R"
        case direction
        when 1
          ci += 1
        when 2
          ri += 1
        when 3
          ci -= 1
        when 4
          ri -= 1
        end
      when "L"
        case direction
        when 1
          ci -= 1
        when 2
          ri -= 1
        when 3
          ci += 1
        when 4
          ri += 1
        end
      end
      break unless @matrix[ri] && @matrix[ri][ci]

      cell = @matrix[ri][ci]
      break if cell == "."

      current_count += 1
    end
    # need to account the last cell checked is one too far
    # probs could deal with this in the loop above but :shrug:
    case current_dir
    when "R"
      ci -= 1 if direction == 1
      ri -= 1 if direction == 2
      ci += 1 if direction == 3
      ri += 1 if direction == 4
    when "L"
      ci += 1 if direction == 1
      ri += 1 if direction == 2
      ci -= 1 if direction == 3
      ri -= 1 if direction == 4
    end
    [ri, ci, current_count]
  end

  def next_dir(direction, left_of_cell, right_of_cell, above_cell, below_cell)
    case direction
    when 1
      if left_of_cell == "#"
        "L"
      elsif right_of_cell == "#"
        "R"
      end
    when 2
      if above_cell == "#"
        "L"
      elsif below_cell == "#"
        "R"
      end
    when 3
      if right_of_cell == "#"
        "L"
      elsif left_of_cell == "#"
        "R"
      end
    when 4
      if below_cell == "#"
        "L"
      elsif above_cell == "#"
        "R"
      end
    end
  end

  def turn(ri, ci, direction, current_dir)
    case direction
    when 1
      @matrix[ri][ci] = ">" if current_dir == "R"
      @matrix[ri][ci] = "<" if current_dir == "L"
    when 2
      @matrix[ri][ci] = "v" if current_dir == "R"
      @matrix[ri][ci] = "^" if current_dir == "L"
    when 3
      @matrix[ri][ci] = "<" if current_dir == "R"
      @matrix[ri][ci] = ">" if current_dir == "L"
    when 4
      @matrix[ri][ci] = "^" if current_dir == "R"
      @matrix[ri][ci] = "v" if current_dir == "L"
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/ClassLength, Metrics/BlockLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity,Naming/MethodParameterName
