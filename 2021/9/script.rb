matrix = File.open('data.txt', 'r').map{ |l| l.strip.split('').map(&:to_i) }

def at(matrix, x, y)
  if x >= 0 && x < matrix.first.length && y >= 0 && y < matrix.length
    return matrix[y][x]
  end
  Float::INFINITY
end

mins = []

for y in (0..matrix.length - 1) do
  for x in (0..matrix.first.length - 1) do
    if at(matrix, x, y) < at(matrix, x - 1, y - 1) && at(matrix, x, y) < at(matrix, x - 1, y) && at(matrix, x, y) < at(matrix, x - 1, y + 1) && at(matrix, x, y) < at(matrix, x, y - 1) && at(matrix, x, y) < at(matrix, x, y + 1) && at(matrix, x, y) < at(matrix, x + 1, y - 1) && at(matrix, x, y) < at(matrix, x + 1, y) && at(matrix, x, y) < at(matrix, x + 1, y + 1)
      mins << { x: x, y: y }
    end
  end
end

puts '# Day 9 - Part 1:'
puts mins.map { |p| matrix[p[:y]][p[:x]] + 1 }.reduce(&:+)

def basin_lookahead matrix, basin_points, point
  if basin_points.include? point
    return
  end

  if matrix[point[:y]][point[:x]] < 9
    basin_points << point

    if point[:y] - 1 >= 0
      basin_lookahead matrix, basin_points, { x: point[:x], y: point[:y] - 1 }
    end
    if point[:y] + 1 < matrix.length
      basin_lookahead matrix, basin_points, { x: point[:x], y: point[:y] + 1 }
    end
    if point[:x] - 1 >= 0
      basin_lookahead matrix, basin_points, { x: point[:x] - 1, y: point[:y] }
    end
    if point[:x] + 1 < matrix.first.length
      basin_lookahead matrix, basin_points, { x: point[:x] + 1, y: point[:y] }
    end
  end
end

basins = mins.map do |point|
  basin_points = []
  basin_lookahead matrix, basin_points, point
  basin_points
end

puts '# Day 9 - Part 2:'
puts basins.sort_by(&:length).last(3).map(&:length).reduce(&:*)
