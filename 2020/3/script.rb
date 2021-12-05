lines = File.open('data.txt', 'r').map{ |l| l.strip }

def check(lines, right, down)
  lines.each_with_index.map do |l, i|
    (i % down == 0) && l[(i / down) * right % l.size] == '#' ? 1 : 0
  end.reduce(&:+)
end

puts '# Day 3 - Part 1:'
puts check(lines, 3, 1)
puts '# Day 3 - Part 2:'
puts check(lines, 1, 1) * check(lines, 3, 1) * check(lines, 5, 1) * check(lines, 7, 1) * check(lines, 1, 2)
