input = File.readlines('data.txt').map { |l| l.strip.split('').map(&:to_i) }

def check_if_visible row, col, x, y, val
  (0..x-1).map { |i| row[i] < val }.reduce(&:&) ||
  (x+1..row.size-1).map { |i| row[i] < val }.reduce(&:&) ||
  (0..y-1).map { |i| col[i] < val }.reduce(&:&) ||
  (y+1..col.size-1).map { |i| col[i] < val }.reduce(&:&)
end

def scenic_score row, col, x, y, val
  count_l = 0
  for t in row[0..x-1].reverse
    count_l += 1
    break if t >= val
  end
  count_r = 0
  for t in row[x+1..]
    count_r += 1
    break if t >= val
  end
  count_u = 0
  for t in col[0..y-1].reverse
    count_u += 1
    break if t >= val
  end
  count_d = 0
  for t in col[y+1..]
    count_d += 1
    break if t >= val
  end
  return count_d * count_u * count_l * count_r
end

visible = input.size * 4 - 4
scores = []

(1..input.size - 2).each_with_index do |y|
  row = input[y]
  (1..row.size - 2).each_with_index do |x|
    col = input.map { |l| l[x] }
    visible +=1 if check_if_visible(row, col, x, y, input[y][x])
    scores << scenic_score(row, col, x, y, input[y][x])
  end
end

puts "Part 1"
p visible
puts "Part 2"
p scores.max