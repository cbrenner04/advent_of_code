input_1 =
  'RRLUDDLDUDUDUDRDDDRDDRLUUUDRUDURURURLRDDULLLDRRRRULDDRDDURDLURLURRUULRURDD' \
  'DDLDDRRLDUDUUDURURDLDRRURDLLLDLLRUDRLDDRUULLLLLRRLDUDLUUDRUULLRLLLRLUURDLD' \
  'LLDDRULDLUURRURLUUURLLDDULRDULULRULDDLRDDUUDLRRURLLURURLDDLURRLUURRRRLDRDL' \
  'DUDRUDDRULLDUDDLRRLUUUUUDDLLDRLURDDRLLUDULDRDDLLUURUUUURDRLRLLULUULULLRRDL' \
  'ULRUDURDLRLRDDDRULLUULRURULLLUDUURUUUURUULDURDRRRULRLULDLRRULULUUDDDRDURLL' \
  'URLLDUUUUDULRDLRDUUDDLDUDRLLRLRRRLULUDDDURLRRURUDDDRDRDRLLRDRDLDDRRDRDLLRL' \
  'LLRRULRDDURRDUDRURDLDULLRRLURLRLLDURRRLLDRRURRRUULDRLDUULRDLDLURUDLLDLLUUD' \
  'DDUUUDRL'
input_2 =
  'DLRRDRRDDRRDURLUDDDDDULDDLLDRLURDDDDDDRDDDRDDDLLRRULLLRUDULLDURULRRDLURURU' \
  'DRUURDRLUURRUDRUULUURULULDDLLDDRLDUDDRDRDDUULDULDDLUDUDDUDLULLUDLLLLLRRRUU' \
  'RLUUUULRURULUDDULLLRLRDRUUULULRUUUULRDLLDLDRDRDRDRRUUURULDUUDLDRDRURRUDDRL' \
  'DULDDRULRRRLRDDUUDRUDLDULDURRDUDDLULULLDULLLRRRDULLLRRURDUURULDRDURRURRRRD' \
  'LDRRUDDLLLDRDRDRURLUURURRUUURRUDLDDULDRDRRURDLUULDDUUUURLRUULRUURLUUUDLUDR' \
  'LURUDLDLDLURUURLDURDDDDRURULLULLDRDLLRRLDLRRRDURDULLLDLRLDR'
input_3 =
  'URURLLDRDLULULRDRRDDUUUDDRDUURULLULDRLUDLRUDDDLDRRLURLURUUDRLDUULDRDURRLLU' \
  'DLDURRRRLURLDDRULRLDULDDRRLURDDRLUDDULUDULRLDULDLDUDRLLDDRRRDULLDLRRLDRLUR' \
  'LUULDDDDURULLDLLLDRRLRRLLRDDRDLDRURRUURLLDDDLRRRRRDLRRDRLDDDLULULRLUURULUR' \
  'UUDRULRLLRDLDULDRLLLDLRRRUDURLUURRUDURLDDDRDRURURRLRRLDDRURULDRUURRLULDLUD' \
  'UULDLUULUDURRDDRLLLRLRRLUUURRDRUULLLRUUURLLDDRDRULDULURRDRURLRRLRDURRURRDL' \
  'DUDRURUULULDDUDUULDRDURRRDLURRLRLDUDRDULLURLRRUDLUDRRRULRURDUDDDURLRULRRUD' \
  'UUDDLLLURLLRLLDRDUURDDLUDLURDRRDLLRLURRUURRLDUUUUDUD'
input_4 =
  'DRRDRRRLDDLDUDRDLRUUDRDUDRRDUDRDURRDDRLLURUUDRLRDDULLUULRUUDDRLDLRULDLRLDU' \
  'DULUULLLRDLURDRDURURDUDUDDDRRLRRLLRULLLLRDRDLRRDDDLULDLLUUULRDURRULDDUDDDU' \
  'RRDRDRDRULRRRDRUDLLDDDRULRRLUDRDLDLDDDLRLRLRLDULRLLRLRDUUULLRRDLLRDULURRLD' \
  'UDDULDDRLUDLULLRLDUDLULRDURLRULLRRDRDDLUULUUUULDRLLDRDLUDURRLLDURLLDDLLUUL' \
  'LDURULULDLUUDLRURRRULUDRLDRDURLDUDDULRDRRDDRLRRDDRUDRURULDRRLUURUDULDDDLRR' \
  'RRDRRRLLURUURLRLULUULLRLRDLRRLLUULLDURDLULURDLRUUDUUURURUURDDRLULUUULRDRDR' \
  'UUDDDRDRL'
input_5 =
  'RLRUDDUUDDDDRRLRUUDLLDRUUUDRRDLDRLRLLDRLUDDURDLDUDRRUURULLRRLUULLUDRDRUDDU' \
  'LRLLUDLULRLRRUUDLDLRDDDRDDDUDLULDLRRLUDUDDRRRRDRDRUUDDURLRDLLDLDLRRDURULDR' \
  'LRRURULRDDLLLRULLRUUUDLDUURDUUDDRRRDDRLDDRULRRRDRRLUDDDRUURRDRRDURDRUDRRDL' \
  'UDDURRLUDUDLLRUURLRLLLDDURUDLDRLRLLDLLULLDRULUURLDDULDDRDDDURULLDRDDLURRDD' \
  'RRRLDLRLRRLLDLLLRDUDDULRLUDDUULUDLDDDULULDLRDDLDLLLDUUDLRRLRDRRUUUURLDLRRL' \
  'DULURLDRDURDDRURLDLDULURRRLRUDLDURDLLUDULDDU'

array_1 = input_1.split('')
array_2 = input_2.split('')
array_3 = input_3.split('')
array_4 = input_4.split('')
array_5 = input_5.split('')

# 1 2 3
# 4 5 6
# 7 8 9

# start at 5
# U is up
# L is left
# R is right
# D is down

# unless current position is 1, 4, 7 and direction is L make move
# unless current position is 3, 6, 9 and direction is R make move
# unless current position is 1, 2, 3 and direction is U make move
# unless current position is 7, 8, 9 and direction is D make move

# if move is up -3 from current position
# if move is down +3 from current position
# if move is left -1 from current position
# if move is right +1 from current position

def illegal_left?(current_position, move)
  (current_position == 1 || current_position == 4 || current_position == 7) &&
    (move == 'L')
end

def illegal_right?(current_position, move)
  (current_position == 3 || current_position == 6 || current_position == 9) &&
    (move == 'R')
end

def illegal_up?(current_position, move)
  (current_position == 1 || current_position == 2 || current_position == 3) &&
    (move == 'U')
end

def illegal_down?(current_position, move)
  (current_position == 7 || current_position == 8 || current_position == 9) &&
    (move == 'D')
end

def illegal_move?(current_position, move)
  illegal_left?(current_position, move) ||
    illegal_right?(current_position, move) ||
    illegal_up?(current_position, move) ||
    illegal_down?(current_position, move)
end

def make_move(current_position, move)
  case move
  when 'U'
    current_position -= 3
  when 'D'
    current_position += 3
  when 'L'
    current_position -= 1
  when 'R'
    current_position += 1
  end

  current_position
end

current_position = 5

array_1.each do |move|
  next if illegal_move?(current_position, move)
  current_position = make_move(current_position, move)
end
puts current_position

current_position = 5

array_2.each do |move|
  next if illegal_move?(current_position, move)
  current_position = make_move(current_position, move)
end
puts current_position

current_position = 5

array_3.each do |move|
  next if illegal_move?(current_position, move)
  current_position = make_move(current_position, move)
end
puts current_position

current_position = 5

array_4.each do |move|
  next if illegal_move?(current_position, move)
  current_position = make_move(current_position, move)
end
puts current_position

current_position = 5

array_5.each do |move|
  next if illegal_move?(current_position, move)
  current_position = make_move(current_position, move)
end
puts current_position
