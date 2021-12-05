instructions = File.open('data.txt', 'r').map do |l|
  code = l.strip.scan(/(\w+?)(?=\s)(.+)/).flatten
  { action: code[0], value: code[1].to_i, count: 0 }
end

def evaluate data, index, raise_on_loop
  if data[index][:count] > 0
    raise StandardError.new 'Infinite loop' if raise_on_loop
    return 0
  end
  if index >= data.size
    return 0
  end
  data[index][:count] = 1

  acc = 0
  next_op = index
  case data[index][:action]
  when 'acc'
    acc += data[index][:value]
    next_op = index + 1
  when 'jmp'
    next_op += data[index][:value]
  when 'nop'
    next_op = index + 1
  end
  if next_op < data.size
    return acc + evaluate(data, next_op, raise_on_loop)
  end
  acc
end

puts '# Day 8 - Part 1:'
iteration = Marshal.load(Marshal.dump(instructions))
puts evaluate(iteration, 0, false)

count = 0
iteration = Marshal.load(Marshal.dump(instructions))
for i in (0..instructions.size - 1)
  begin
    count = evaluate(iteration, 0, true)
    break
  rescue
    iteration = Marshal.load(Marshal.dump(instructions))
  end
  if iteration[i][:action] != 'acc'
    iteration[i][:action] = iteration[i][:action] == 'jmp' ? 'nop' : 'jmp'
  end
end

puts '# Day 8 - Part 2:'
puts count