require 'matrix'

lines = File.open('data.txt', 'r').map{ |l| l.strip }

def find_overlaps lines, exclude_diagonal
  matrix = Matrix.zero(1000).to_a
  vectors = lines.map { |line| start, stop = line.split('->'); x1, y1 = start.split(',').map(&:to_i); x2, y2 = stop.split(',').map(&:to_i); { x1: x1, y1: y1, x2: x2, y2: y2 } }
  vectors.each do |v|
    if v[:x1] == v[:x2] # vertical
      distance = (v[:y2] - v[:y1]).abs()
      (0..distance).each { |n| matrix[v[:y1] + (v[:y1] > v[:y2] ? -n : n)][v[:x1]] += 1 }
    elsif v[:y1] == v[:y2] # horizontal
      distance = (v[:x2] - v[:x1]).abs()
      (0..distance).each { |n| matrix[v[:y1]][v[:x1] + (v[:x1] > v[:x2] ? -n : n)] += 1 }
    elsif !exclude_diagonal # diagonal
      distance = (v[:x2] - v[:x1]).abs()
      (0..distance).each { |n| matrix[v[:y1] + (v[:y1] > v[:y2] ? -n : n)][v[:x1] + (v[:x1] > v[:x2] ? -n : n)] += 1 }
    end
  end
  return matrix.flatten.select { |n| n > 1 }.count
end

puts '# Day 5 - Part 1:'
puts find_overlaps lines, true

puts '# Day 5 - Part 2:'
puts find_overlaps lines, false