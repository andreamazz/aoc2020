lines = File.open('data.txt', 'r').map{ |l| l.strip }

bits = []
lines.first.split('').each_with_index do |c, i|
  ones = 0
  lines.each do |line|
    if line[i] == '1'
      ones += 1
    end
  end
  bits << ((ones > lines.count / 2) ? '1' : '0')
end
gamma = bits.join('').to_i(2)

puts '# Day 3 - Part 1:'
puts gamma * (gamma ^ ((2 ** lines.first.length) - 1))

def count_and_filter dataset, bit, search_most=true
  if dataset.length == 1 || bit >= dataset.first.length
    return dataset.first
  end

  ones = 0
  dataset.each do |line|
    if line[bit] == '1'
      ones += 1
    end
  end
  zeros = dataset.length - ones
  test_value = '0'
  if search_most
    test_value = ((ones >= zeros) ? '1' : '0')
  else
    test_value = ((ones < zeros) ? '1' : '0')
  end
  filtered = dataset.select { |line| line[bit] === test_value }

  count_and_filter filtered, bit + 1, search_most
end

oxygen = count_and_filter lines, 0, true
co2 = count_and_filter lines, 0, false

puts '# Day 3 - Part 2:'
puts oxygen.to_i(2) * co2.to_i(2)
