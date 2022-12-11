require 'set'

input = File.readlines('data.txt').map { |l| l.strip }

$x = 1
$cycles = 0
$stops = [20, 60, 100, 140, 180, 220]
$values = []
$display = Array.new(6, "")

def check_cycles
  display_line = ($cycles - 1) / 40
  pos = ($cycles - 1) % 40
  $display[display_line] = "#{$display[display_line]}#{(pos >= $x - 1 && pos <= $x + 1) ? '#' : '.'}"

  if $cycles == $stops.first
    $values << $x * $cycles
    $stops.shift
  end
end

input.each do |l|
  op = l.match(/([a-z]+)/)[0]
  value = l.match(/(-*\d+)/)
  value = value ? value[0].to_i : 0

  case op
  when 'noop'
    $cycles += 1
    check_cycles
  when 'addx'
    $cycles +=1
    check_cycles
    $cycles +=1
    check_cycles
    $x += value
  end
end

puts "Part 1"
p $values.reduce(&:+)
puts "Part 2"
puts $display
