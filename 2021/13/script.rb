require 'matrix'

input = File.open('data.txt', 'r').map{ |l| l.strip }
coords = input.select { |l| l.include? ',' }.map do |p|
  x, y = p.split(',')
  { x: x.to_i, y: y.to_i }
end
folds = input.select { |l| l.include? 'fold along ' }.map do |f|
  match = f.match /([xy])=([0-9]+)/
  { orientation: match[1], position: match[2].to_i }
end

cols = coords.map { |p| p[:x] }.max()
rows = coords.map { |p| p[:y] }.max()

matrix = Matrix.zero(rows + 1, cols + 1).to_a

coords.each do |p|
  matrix[p[:y]][p[:x]] = 1
end

def fold_vertically position, matrix, rows, cols
  for row in (0..position - 1)
    matrix[row].each_with_index { |r, i| matrix[row][i] |= matrix[rows - row][i] }
  end
end

def fold_horizontally position, matrix, rows, cols
  for row in (0..rows)
    for col in (0..position - 1)
      matrix[row][col] |= matrix[row][cols - col]
    end
  end
end

folds.each_with_index do |f, i|
  if f[:orientation] == 'x'
    fold_horizontally f[:position], matrix, rows, cols
    cols = f[:position] - 1
  else
    fold_vertically f[:position], matrix, rows, cols
    rows = f[:position] - 1
  end

  if i == 0
    count = 0
    for r in (0..rows)
      for c in (0..cols)
        count += matrix[r][c]
      end
    end

    puts '# Day 13 - Part 1:'
    p count
  end
end

puts '# Day 13 - Part 2:'
for r in (0..rows)
  p matrix[r][0..cols].map { |i| i == 0 ? ' ' : '#' }.join('')
end
