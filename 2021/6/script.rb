require 'matrix'

input = File.open('data.txt', 'r').map{ |l| l.strip }.first.split(',').map(&:to_i)

counts = [0, 0, 0, 0, 0, 0, 0, 0, 0]
input.each { |n| counts[n] += 1 }

def run counts
  zero = counts[0]
  (1..8).each do |n|
    counts[n - 1] = counts[n]
    counts[n] = 0
  end
  counts[8] = zero
  counts[6] += zero
end

puts '# Day 6 - Part 1:'
(0..79).each { run(counts) }
puts counts.reduce(&:+)

puts '# Day 6 - Part 2:'
(0..255).each { run(counts) }
puts counts.reduce(&:+)