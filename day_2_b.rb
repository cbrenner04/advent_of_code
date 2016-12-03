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

#     1
#   2 3 4
# 5 6 7 8 9
#   A B C
#     D

options = %w(1 2 3 4 5 6 7 8 9 A B C D)

# unless index is 4, 1, 0, 3, 8 and move is up make move
# unless index is 4, 9, 12, 11, 8 and move is down make move
# unless index is 0, 3, 8, 11, 12 and move is right make move
# unless index is 0, 1, 4, 9, 12 and move is left make move

# if move is up and index is 2 or 12 subtract 2 else subtract 4
# if move is down and indes is 0 or 10 add 2 else add 4
# if move is left  subtract 1
# if move is right add 1

STARTING_POSITION = 4
VERTICAL_CHANGE = 4
ALT_VERTICAL_CHANGE = 2
HORIZONTAL_CHANGE = 1

def illegal_up?(index, move)
  (index == 4 || index == 1 || index.zero? || index == 3 || index == 8) &&
    (move == 'U')
end

def illegal_down?(index, move)
  (index == 4 || index == 9 || index == 12 || index == 11 || index == 8) &&
    (move == 'D')
end

def illegal_right?(index, move)
  (index.zero? || index == 3 || index == 8 || index == 11 || index == 12) &&
    (move == 'R')
end

def illegal_left?(index, move)
  (index.zero? || index == 1 || index == 4 || index == 9 || index == 12) &&
    (move == 'L')
end

def illegal_move?(index, move)
  illegal_left?(index, move) ||
    illegal_right?(index, move) ||
    illegal_up?(index, move) ||
    illegal_down?(index, move)
end

def make_move(index, move)
  case move
  when 'U'
    if index == 2 || index == 12
      index - ALT_VERTICAL_CHANGE
    else
      index - VERTICAL_CHANGE
    end
  when 'D'
    if index.zero? || index == 10
      index + ALT_VERTICAL_CHANGE
    else
      index + VERTICAL_CHANGE
    end
  when 'L'
    index - HORIZONTAL_CHANGE
  when 'R'
    index + HORIZONTAL_CHANGE
  end
end

[array_1, array_2, array_3, array_4, array_5].each do |array|
  index = STARTING_POSITION

  array.each do |move|
    next if illegal_move?(index, move)
    index = make_move(index, move)
  end
  puts options[index]
end
