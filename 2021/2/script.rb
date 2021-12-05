lines = File.open('data.txt', 'r').map{ |l| l.strip }

pos = { x: 0, y: 0 }
lines.each do |line|
  command = line.split[0]
  value = line.split[1].to_i
  case command
  when 'forward'
    pos[:x] += value
  when 'down'
    pos[:y] += value
  when 'up'
    pos[:y] -= value
  end
end

puts '# Day 2 - Part 1:'
puts pos[:x] * pos[:y]

pos = { x: 0, y: 0 }
aim = 0
lines.each do |line|
  command = line.split[0]
  value = line.split[1].to_i
  case command
  when 'forward'
    pos[:x] += value
    pos[:y] += aim * value
  when 'down'
    aim += value
  when 'up'
    aim -= value
  end
end

puts '# Day 2 - Part 2:'
puts pos[:x] * pos[:y]
