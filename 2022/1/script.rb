batches = File.readlines('data.txt', "\n\n").map(&:rstrip).map(&:split)

sums = batches.each_with_index.map { |a, i| a.map(&:to_i).reduce(&:+) }.sort().reverse()

puts "Part 1"
puts sums[0]

puts "Part 2"
puts sums[0..2].reduce(&:+)
