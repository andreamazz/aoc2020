instructions = File.open('data.txt', 'r').map{ |l| l.strip }

pos = { x: 0, y: 0 }
d = { x: 1, y: 0 }

class Float
  def to_rad
    self / 180 * Math::PI
  end
end

def rotated_direction d, angle
  { x: (d[:x] * Math.cos(angle.to_rad) - d[:y] * Math.sin(angle.to_rad)).round, y: (d[:y] * Math.cos(angle.to_rad) + d[:x] * Math.sin(angle.to_rad)).round }
end

instructions.each do |i|
  value = i[1..].to_i
  case i[0]
  when 'L'
    d = rotated_direction(d, value.to_f)
  when 'R'
    d = rotated_direction(d, -value.to_f)
  when 'N'
    pos[:y] += value
  when 'S'
    pos[:y] -= value
  when 'E'
    pos[:x] += value
  when 'W'
    pos[:x] -= value
  when 'F'
    pos = { x: pos[:x] + value * d[:x], y: pos[:y] + value * d[:y] }
  end
end

ship_pos = { x: 0, y: 0 }
waypoint_pos = { x: 10, y: 1 }

instructions.each do |i|
  value = i[1..].to_i
  case i[0]
  when 'L'
    waypoint_pos = rotated_direction(waypoint_pos, value.to_f)
  when 'R'
    waypoint_pos = rotated_direction(waypoint_pos, -value.to_f)
  when 'N'
    waypoint_pos[:y] += value
  when 'S'
    waypoint_pos[:y] -= value
  when 'E'
    waypoint_pos[:x] += value
  when 'W'
    waypoint_pos[:x] -= value
  when 'F'
    ship_pos = { x: ship_pos[:x] + value * waypoint_pos[:x], y: ship_pos[:y] + value * waypoint_pos[:y] }
  end
end

puts '# Day 12 - Part 1:'
puts pos[:x].abs + pos[:y].abs
puts '# Day 12 - Part 2:'
puts ship_pos[:x].abs + ship_pos[:y].abs
