require 'matrix'

input = File.open('data.txt', 'r').map{ |l| l.strip.chars.map(&:to_i) }

def run input
  rows = input.length
  cols = input.first.length

  to_visit = [{ x: 0, y: 0, risk: 0}]
  visited = []
  lowest_risk = { { x: 0, y: 0 } => 0 }
  while to_visit.length > 0 do
    position = to_visit.pop()
    if position[:x] == rows - 1 && position[:y] == rows - 1
      return position[:risk]
    end

    for pos in [{ x: position[:x] + 1, y: position[:y] }, { x: position[:x], y: position[:y] + 1 }, { x: position[:x] - 1, y: position[:y] }, { x: position[:x], y: position[:y] - 1 }]
      if pos[:x] < cols && pos[:y] < rows && pos[:x] >= 0 && pos[:y] >= 0 && !visited.include?({ x: pos[:x], y: pos[:y] })
        risk = position[:risk] + input[pos[:y]][pos[:x]]
        if lowest_risk[{ x: pos[:x], y: pos[:y] }] == nil || lowest_risk[{ x: pos[:x], y: pos[:y] }] > risk
          lowest_risk[{ x: pos[:x], y: pos[:y] }] = risk
          to_visit << { x: pos[:x], y: pos[:y], risk: risk }
        end
      end
    end
    visited << { x: pos[:x], y: pos[:y] }
    to_visit = to_visit.sort_by { |v| v[:risk] }.reverse
  end
end


puts '# Day 15 - Part 1:'
p run(input)

rows = input.length
cols = input.first.length
big_cave = Matrix.zero(rows * 5, cols * 5).to_a
for x in (0..rows-1)
  for y in (0..cols-1)
    for i in (0..4)
      for j in (0..4)
        big_cave[y + rows * i][x + cols * j] = (input[y][x] - 1 + i + j) % 9 + 1
      end
    end
  end
end

puts '# Day 15 - Part 2:'
p run(big_cave)