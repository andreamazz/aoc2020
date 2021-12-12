input = File.open('data.txt', 'r').map{ |l| l.strip }.map { |l| l.split('').map(&:to_i) }

flashes = []

def increase flashes, input, row, col
  if row < 0 || row >= input.length || col < 0 || col >= input.first.length
    return false
  end

  coords = { row: row, col: col }
  if !flashes.include?(coords)
    input[row][col] += 1
  end
  if input[row][col] > 9
    input[row][col] = 0
    if !flashes.include?(coords)
      flashes << coords
      return true
    end
  end
  return false
end

def increase_neighbors flashes, input, row, col
  increase_neighbors(flashes, input, row - 1, col - 1) if increase(flashes, input, row - 1, col - 1)
  increase_neighbors(flashes, input, row - 1, col) if increase(flashes, input, row - 1, col)
  increase_neighbors(flashes, input, row - 1, col + 1) if increase(flashes, input, row - 1, col + 1)

  increase_neighbors(flashes, input, row, col - 1) if increase(flashes, input, row, col - 1)
  increase_neighbors(flashes, input, row, col + 1) if increase(flashes, input, row, col + 1)

  increase_neighbors(flashes, input, row + 1, col - 1) if increase(flashes, input, row + 1, col - 1)
  increase_neighbors(flashes, input, row + 1, col) if increase(flashes, input, row + 1, col)
  increase_neighbors(flashes, input, row + 1, col + 1) if increase(flashes, input, row + 1, col + 1)
end

def step flashes, input, step_count
  flashes << []
  for row in (0..input.length - 1)
    for col in (0..input[row].length - 1)
      if increase(flashes[step_count], input, row, col)
        increase_neighbors(flashes[step_count], input, row, col)
      end
    end
  end
end

for i in (0..99)
  step(flashes, input, i)
end

puts '# Day 11 - Part 1:'
p flashes.map(&:length).reduce(&:+)

step_count = 100

begin
  step(flashes, input, step_count)
  step_count += 1
end while ((input.map { |i| i.reduce(&:+) }.reduce(&:+)) > 0)

puts '# Day 11 - Part 2:'
puts step_count