# frozen_string_literal: true

# INPUT = "x00: 1
# x01: 1
# x02: 1
# y00: 0
# y01: 1
# y02: 0

# x00 AND y00 -> z00
# x01 XOR y01 -> z01
# x02 OR y02 -> z02"

INPUT = "x00: 1
x01: 0
x02: 1
x03: 1
x04: 0
y00: 1
y01: 1
y02: 1
y03: 1
y04: 1

ntg XOR fgs -> mjb
y02 OR x01 -> tnw
kwq OR kpj -> z05
x00 OR x03 -> fst
tgd XOR rvg -> z01
vdt OR tnw -> bfw
bfw AND frj -> z10
ffh OR nrd -> bqk
y00 AND y03 -> djm
y03 OR y00 -> psh
bqk OR frj -> z08
tnw OR fst -> frj
gnj AND tgd -> z11
bfw XOR mjb -> z00
x03 OR x00 -> vdt
gnj AND wpb -> z02
x04 AND y00 -> kjc
djm OR pbm -> qhw
nrd AND vdt -> hwm
kjc AND fst -> rvg
y04 OR y02 -> fgs
y01 AND x02 -> pbm
ntg OR kjc -> kwq
psh XOR fgs -> tgd
qhw XOR tgd -> z09
pbm OR djm -> kpj
x03 XOR y03 -> ffh
x00 XOR y04 -> ntg
bfw OR bqk -> z06
nrd XOR fgs -> wpb
frj XOR qhw -> z04
bqk OR frj -> z07
y03 OR x01 -> nrd
hwm AND bqk -> z03
tgd XOR rvg -> z12
tnw OR pbm -> gnj"

def operate(a, b, operator)
  case operator
  when "AND"
    a == 1 && b == 1 ? 1 : 0
  when "OR"
    a == 1 || b == 1 ? 1 : 0
  when "XOR"
    a == b ? 0 : 1
  else
    throw "you shouldn't be here"
  end
end

gates, connections = INPUT.split("\n\n")
lookup = {}
gates.each_line(chomp: true) do |line|
  key, value = line.split(": ")
  lookup[key] = value.to_i
end
connections = connections.each_line(chomp: true).to_a
outputs = {}
until connections.empty?
  connections.each do |instruction|
    operation, output_key = instruction.split(" -> ")
    operators = operation.split
    next unless (output_key.start_with?("z") || !lookup.keys.include?(output_key)) &&
                lookup.keys.include?(operators.first) && lookup.keys.include?(operators.last)

    connections.delete(instruction)
    value = operate(lookup[operators.first], lookup[operators.last], operators[1])
    lookup[output_key] = value
    outputs[output_key] = value if output_key.start_with?("z")
  end
end

# part one
p outputs.keys.sort.reverse.map { |key| outputs[key] }.join.to_i(2)

# part two
def correct(lookup)
  x_s = lookup.keys.map { |key| key if key.start_with?("x") }
              .compact.sort.reverse.map { |key| lookup[key] }.join.to_i(2)
  y_s = lookup.keys.map { |key| key if key.start_with?("y") }
              .compact.sort.reverse.map { |key| lookup[key] }.join.to_i(2)
  z_s = lookup.keys.map { |key| key if key.start_with?("z") }
              .compact.sort.reverse.map { |key| lookup[key] }.join
  (x_s + y_s).to_s(2) == z_s
end

p correct(lookup)
p lookup.keys
