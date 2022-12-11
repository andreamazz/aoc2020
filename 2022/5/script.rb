input = File.read('data.txt').split(/(\s\d.+\n\n)/)
crane_9000 = nil
input[0].lines.each do |l|
  m = l.scan /(.{3,4})/
  if !crane_9000
    crane_9000 = Array.new(m.size)
    (0..m.size - 1).each { |i| crane_9000[i] = [] }
  end

  m.to_a.each_with_index do |a, i|
    char = a[0].match(/[A-Z]/)
    if char
      crane_9000[i].push(char[0])
    end
  end
end

moves = input[2].lines.map do |l|
  m = l.scan(/(\d+)/).to_a
  { n: m[0][0].to_i, from: m[1][0].to_i, to: m[2][0].to_i }
end

crane_9001 = Marshal.load(Marshal.dump(crane_9000))

moves.each do |m|
  (0..m[:n] - 1).each do |i|
    char = crane_9000[m[:from] - 1].shift
    crane_9000[m[:to] - 1].unshift(char)
  end
end

moves.each do |m|
  chars = crane_9001[m[:from] - 1].shift(m[:n])
  chars.reverse.each { |c| crane_9001[m[:to] - 1].unshift(c) }
end

puts "Part 1"
p crane_9000.map(&:first).join
puts "Part 2"
p crane_9001.map(&:first).join
