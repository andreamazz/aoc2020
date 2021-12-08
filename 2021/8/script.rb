lines = File.open('data.txt', 'r').map{ |l| l.strip }
signals = lines.map { |l| l.split('|').first }
output = lines.map { |l| l.split('|').last }

puts '# Day 8 - Part 1:'
puts output.map { |out| out.split.select { |sequence| [2, 4, 3, 7].include? sequence.length }.count }.reduce(&:+)

results = []
signals.each_with_index do |signal, index|
  out = output[index]

  numbers = []

  numbers[1] = signal.split.select { |s| s.length == 2 }.first
  numbers[7] = signal.split.select { |s| s.length == 3 }.first
  numbers[4] = signal.split.select { |s| s.length == 4 }.first
  numbers[3] = signal.split.select { |s| s.length == 5 && (s.split('') - numbers[7].split('')).length == 2 }.first
  numbers[8] = signal.split.select { |s| s.length == 7 }.first
  numbers[9] = signal.split.select { |s| s.length == 6 && ((s.split('') - numbers[4].split('')).length == 2) }.first
  numbers[0] = signal.split.select { |s| s.length == 6 && s != numbers[9] && s.split('').include?(numbers[1][0]) && s.split('').include?(numbers[1][1]) }.first
  numbers[6] = signal.split.select { |s| s.length == 6 && s != numbers[9] && s != numbers[0] }.first
  numbers[5] = signal.split.select { |s| s.length == 5 && ((numbers[6].split('') - s.split('')).length == 1) }.first
  numbers[2] = signal.split.select { |s| s.length == 5 && s != numbers[5] && s != numbers[3] }.first

  results << out.split(' ').map { |o| numbers.index(numbers.select { |n| o.chars.sort() == n.chars.sort() }.first) }.join().to_i
end

puts '# Day 8 - Part 2:'
puts results.reduce(&:+)
