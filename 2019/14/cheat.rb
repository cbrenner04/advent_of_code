
INPUT = "10 ORE => 10 A\n1 ORE => 1 B\n7 A, 1 B => 1 C\n7 A, 1 C => 1 D\n7 A, 1 D => 1 E\n7 A, 1 E => 1 FUEL"
# INPUT = "9 ORE => 2 A\n8 ORE => 3 B\n7 ORE => 5 C\n3 A, 4 B => 1 AB\n5 B, 7 C => 1 BC\n4 C, 1 A => 1 CA\n2 AB, 3 BC, 4 CA => 1 FUEL"
# INPUT = "157 ORE => 5 NZVS\n165 ORE => 6 DCFZ\n44 XJWVT, 5 KHKGT, 1 QDVJ, 29 NZVS, 9 GPVTF, 48 HKGWZ => 1 FUEL\n12 HKGWZ, 1 GPVTF, 8 PSHF => 9 QDVJ\n179 ORE => 7 PSHF\n177 ORE => 5 HKGWZ\n7 DCFZ, 7 PSHF => 2 XJWVT\n165 ORE => 2 GPVTF\n3 DCFZ, 7 NZVS, 5 HKGWZ, 10 PSHF => 8 KHKGT"
# INPUT = "2 VPVL, 7 FWMGM, 2 CXFTF, 11 MNCFX => 1 STKFG\n17 NVRVD, 3 JNWZP => 8 VPVL\n53 STKFG, 6 MNCFX, 46 VJHF, 81 HVMC, 68 CXFTF, 25 GNMV => 1 FUEL\n22 VJHF, 37 MNCFX => 5 FWMGM\n139 ORE => 4 NVRVD\n144 ORE => 7 JNWZP\n5 MNCFX, 7 RFSQX, 2 FWMGM, 2 VPVL, 19 CXFTF => 3 HVMC\n5 VJHF, 7 MNCFX, 9 VPVL, 37 CXFTF => 6 GNMV\n145 ORE => 6 MNCFX\n1 NVRVD => 8 CXFTF\n1 VJHF, 6 MNCFX => 4 RFSQX\n176 ORE => 6 VJHF"
# INPUT = "171 ORE => 8 CNZTR\n7 ZLQW, 3 B

class Nanofactory
  def initialize data
    @reactions={}
    data.strip.split("\n").each do |line|
      precur, result = line.strip.split('=>')
      amount,elem = result.split(' ')
      @reactions[elem]={:q=>amount.to_i}
      @reactions[elem][:inputs] = precur.split(',').map do |pair|
        amount,elem = pair.split(' ')
        {:e=>elem, :q=>amount.to_i}
      end
    end
  end
  def oreRequired goal, q
    need = {}
    @reactions.keys.each {|e| need[e]=0}
    need['ORE'] = 0
    need[goal] = q
    while !need.keys.all? {|e| e == 'ORE' || need[e] <= 0}
      need.each_pair do |e, q|
        next if e == 'ORE'
        next if q <= 0
        timesToMake = (q.to_f/@reactions[e][:q]).ceil
        @reactions[e][:inputs].each do |reaction|
          need[reaction[:e]] += timesToMake * reaction[:q]
        end
        need[e] -= @reactions[e][:q] * timesToMake
      end
    end
    need['ORE']
  end
end

nf = Nanofactory.new (INPUT)
part1 = nf.oreRequired('FUEL', 1)
puts "part1: #{part1}"

trillion = 1000000000000
upper,lower = trillion,0
while upper!=lower
  mid = (upper + lower)/2
  required = nf.oreRequired('FUEL', mid)
  if required > trillion
    upper = mid-1
  else
    lower = mid+1
  end
  p lower
end
puts "part2: #{lower}"
