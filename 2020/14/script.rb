program = File.open('data.txt', 'r').map{ |l| l.strip }

mem = {}
mask = ''

program.each do |line|
  if line.index 'mask'
    mask = line.split('mask = ')[1]
  else
    data = line.scan(/\[(\d+)\] = (\d+)/).flatten.map(&:to_i)
    value = '%0*b' % [36, data[1]]
    for i in (0..35)
      value[i] = mask[i] == 'X' ? value[i] : mask[i]
    end
    mem[data[0]] = value.to_i(2)
  end
end

puts '# Day 14 - Part 1:'
puts mem.keys.map { |k| mem[k] }.reduce(&:+)

mem = {}
mask = ''

def set_mem mem, address, value
  first_x = address.index('X')
  if first_x
    address[first_x] = '0'
    set_mem(mem, address.clone, value)
    address[first_x] = '1'
    set_mem(mem, address.clone, value)
  else
    mem[address.to_i(2)] = value
  end
end

program.each do |line|
  if line.index 'mask'
    mask = line.split('mask = ')[1]
  else
    data = line.scan(/\[(\d+)\] = (\d+)/).flatten.map(&:to_i)
    address = '%0*b' % [36, data[0]]
    value = data[1].to_i

    for i in (0..35)
      if mask[i] == 'X'
        address[i] = 'X'
      end
      if mask[i] == '1'
        address[i] = '1'
      end
    end
    set_mem(mem, address.clone, value)
  end
end

puts '# Day 14 - Part 2:'
puts mem.keys.map { |k| mem[k] }.reduce(&:+)
