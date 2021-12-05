entries = File.open('data.txt', 'r').map{ |l| l.strip }

def check_occurences(string)
  tokens = string.split
  occurences = tokens.last.scan(tokens[1][0]).size
  occurences >= tokens.first.split('-').first.to_i && occurences <= tokens.first.split('-').last.to_i
end

def check_positions(string)
  tokens = string.split
  (tokens.last[tokens.first.split('-').first.to_i - 1] == tokens[1][0]) ^ (tokens.last[tokens.first.split('-').last.to_i - 1] == tokens[1][0])
end

puts '# Day 2 - Part 1:'
puts entries.map { |e| check_occurences(e) }.inject(0) { |count, i| count += i ? 1 : 0 }
puts '# Day 2 - Part 2:'
puts entries.map { |e| check_positions(e) }.inject(0) { |count, i| count += i ? 1 : 0 }