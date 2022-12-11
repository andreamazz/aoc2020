data = File.readlines('data.txt').map { |d| d.split(",") }

full = 0
partial = 0
data.each do |pairs|
  a = pairs[0].split('-').map(&:to_i);
  b = pairs[1].split('-').map(&:to_i);
  full += 1 if (a[0] >= b[0] && a[1] <= b[1]) || (b[0] >= a[0] && b[1] <= a[1])
  partial += 1 if (a[0]..a[1]).to_a.intersection((b[0]..b[1]).to_a).size > 0
end

puts "Part 1"
puts full
puts "Part 2"
puts partial