input = File.open('data.txt', 'r').map{ |l| l.strip }

mappings = input.select { |l| l.include? '->' }.inject({}) do |object, m|
  pair, insertion = m.split(' -> ')
  object[pair] = insertion
  object
end

pairs = {}
input[0].chars.each_cons(2) do |a, b|
  pairs[a + b] = 1
end
counts = {}
input[0].chars.uniq.each { |char| counts[char] = input[0].count(char) }

def get_result counts
  values = counts.keys.map { |k| counts[k] }
  values.max() - values.min()
end

(0..39).each do |n|
  new_pairs = pairs.dup
  pairs.keys.each_with_index do |key, index|
    count = pairs[key]
    pair = key.chars
    new_char = mappings[pair[0] + pair[1]]
    new_pairs[pair[0] + new_char] = count + (new_pairs[pair[0] + new_char] || 0)
    new_pairs[new_char + pair[1]] = count + (new_pairs[new_char + pair[1]] || 0)
    new_pairs[key] -= count
    counts[new_char] = counts[new_char] != nil ? counts[new_char] + count : count
  end
  pairs = new_pairs.dup
  if n == 9
    puts '# Day 14 - Part 1:'
    puts get_result(counts)
  end
end

puts '# Day 14 - Part 2:'
puts get_result(counts)
