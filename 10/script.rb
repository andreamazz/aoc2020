numbers = [0]
numbers += File.open('data.txt', 'r').map{ |l| l.strip.to_i }
numbers += [numbers.max + 3]
differences = numbers.sort.each_cons(2).map { |pair| pair[1] - pair[0] }
d1 = differences.filter { |n| n == 1 }.size
d3 = differences.filter { |n| n == 3 }.size

puts '# Day 10 - Part 1:'
puts d1 * d3

permutations = differences.chunk { |n| n == 1 }.map do |is_one, ary|
  value = 1
  if is_one && ary.size == 2
    value = 2
  end
  if is_one && ary.size == 3
    value = 4
  end
  if is_one && ary.size == 4
    value = 7
  end
  value
end

puts '# Day 10 - Part 2:'
puts permutations.reduce(&:*)
