data = File.readlines('data.txt')
lines = data.map { |l| [l[(0...l.size/2)], l[(l.size/2...)]] }

def value letter
  if /[[:upper:]]/.match(letter)
    letter.ord() - 38
  else
    letter.ord() - 96
  end
end

puts "Part 1"
puts lines.map { |tuple| tuple[0].split("").intersection(tuple[1].split("")).map { |c| value(c) } }.flatten.reduce(&:+)

puts "Part 2"
puts data.each_slice(3).to_a.map { |triplet| triplet[0].strip.split("") & triplet[1].strip.split("") & triplet[2].strip.split("") }.flatten.map { |c| value(c) }.reduce(&:+)