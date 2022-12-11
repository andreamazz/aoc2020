data = File.read('data.txt')

def check data, how_many
  array = data.split('')
  array.each_with_index do |char, i|
    if i > (how_many - 1) && array[(i-(how_many - 1)..i)].uniq.size == how_many
      return i + 1
    end
  end
end

puts "Part 1"
puts check data, 4
puts "Part 2"
puts check data, 14
