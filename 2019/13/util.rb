# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
def draw(output)
  score = 0
  count = 0
  ball_pos = 0
  paddle_pos = 0
  m = Array.new(25) { Array.new(40) }
  output.each_slice(3) do |set|
    x = set[0]
    y = set[1]
    tile_id = set[2]
    score = tile_id if x == -1 && y.zero?
    count += 1 if tile_id == 2
    if tile_id.zero?
      m[y][x] = " "
    elsif tile_id == 1
      m[y][x] = "|"
    elsif tile_id == 2
      m[y][x] = "□"
    elsif tile_id == 3
      paddle_pos = x
      m[y][x] = "_"
    elsif tile_id == 4
      ball_pos = x
      m[y][x] = "o"
    end
  end
  m.each { |row| puts row.join("") }
  joystick =
    if ball_pos > paddle_pos
      1
    elsif ball_pos < paddle_pos
      -1
    else
      0
    end
  [count, joystick, score]
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
