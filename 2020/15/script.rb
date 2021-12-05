input = '9,6,0,10,18,2,1'.split(',').map(&:to_i)

def count_for input, size
  indexes = {}

  for x in (0..input.size - 2)
    indexes[input[x]] = x
  end

  next_value = input.last
  value = input.last

  for x in ((input.size - 1)..(size - 2))
    next_value = indexes[next_value] ? x - indexes[next_value] : 0
    indexes[value] = x
    value = next_value
  end
  value
end

puts '# Day 15 - Part 1:'
puts count_for input.clone, 2020

puts '# Day 15 - Part 1:'
puts count_for input.clone, 30000000
