numbers = [0]
numbers += File.open('data.txt', 'r').map{ |l| l.strip.to_i }
numbers += [numbers.max + 3]
differences = numbers.sort.each_cons(2).map { |pair| pair[1] - pair[0] }
d1 = differences.filter { |n| n == 1 }.size
d3 = differences.filter { |n| n == 3 }.size

puts '# Day 10 - Part 1:'
puts d1 * d3

permutations = differences.chunk { |n| n == 1 }.map { |is_one, ary| is_one ? (ary.size * (ary.size - 1)) / 2 + 1 : 1 }

puts '# Day 10 - Part 2:'
puts permutations.reduce(&:*)
