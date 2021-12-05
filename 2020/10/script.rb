numbers = [0]
numbers += File.open('data.txt', 'r').map{ |l| l.strip.to_i }
numbers += [numbers.max + 3]
differences = numbers.sort.each_cons(2).map { |pair| pair[1] - pair[0] }

puts '# Day 10 - Part 1:'
puts [1, 3].map { |distance| differences.filter { |n| n == distance }.size }.reduce(&:*)

puts '# Day 10 - Part 2:'
puts differences.chunk { |n| n == 1 }.map { |is_one, ary| is_one ? (ary.size * (ary.size - 1)) / 2 + 1 : 1 }.reduce(&:*)
