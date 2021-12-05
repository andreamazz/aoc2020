answers = File.readlines('data.txt', "\n\n").map(&:rstrip)

puts '# Day 6 - Part 1:'
puts answers.map { |a| a.gsub("\n", '').split('').uniq.join.size }.reduce(&:+)
puts '# Day 6 - Part 2:'
puts answers.map { |a| a.split("\n").map { |group| group.split('') }.reduce(&:&).count }.reduce(&:+)
