notes = File.open('data.txt', 'r').map{ |l| l.strip }
arrival = notes[0].to_i
times = notes[1].split(',').filter { |l| l != 'x' }.map(&:to_i)

next_stop = times.map { |t| { t: (arrival / t + 1) * t, bus: t } }.min { |a, b| a[:t] <=> b[:t] }

puts '# Day 13 - Part 1:'
puts (next_stop[:t] - arrival) * next_stop[:bus]

lines = notes[1].split(',').each_with_index.map { |t, i| t == 'x' ? nil : { bus: t.to_i, offset: i } }.compact

step = 1
t = 1
for i in (0..lines.count - 1)
  loop do
    t += step
    break if lines[..i].map { |b| (t + b[:offset]) % b[:bus] == 0 }.reduce(&:&)
  end
  step *= lines[i][:bus]
end

puts '# Day 13 - Part 2:'
puts t
