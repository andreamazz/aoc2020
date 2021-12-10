input = File.open('data.txt', 'r').map{ |l| l.strip }.map { |l| { line: l, corrupted: nil, completion: nil } }

closing_char = { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }
corruption_score = { ')' => 3, ']' => 57 , '}' => 1197, '>' => 25137 }
completion_score = { ')' => 1, ']' => 2 , '}' => 3, '>' => 4 }

input.each do |data|
  stack = []
  for char in data[:line].chars.each do
    if char == '(' || char == '{' || char == '[' || char == '<'
      stack << char
    elsif char == closing_char[stack.last]
      stack.pop()
    else
      data[:corrupted] = char
      break
    end
  end
  if stack.length > 0 && data[:corrupted] == nil
    completion = stack.map { |c| closing_char[c] }.reverse
    data[:completion] = completion.inject(0) { |s, c| s = s * 5 + completion_score[c] }
  end
end

puts '# Day 10 - Part 1:'
puts input.select { |i| i[:corrupted] != nil }.map { |i| corruption_score[i[:corrupted]] }.reduce(&:+)

completions = input.map { |i| i[:completion] }.compact.sort

puts '# Day 10 - Part 2:'
puts completions[completions.length / 2]