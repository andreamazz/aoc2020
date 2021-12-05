numbers = File.open('data.txt', 'r').map{ |l| l.strip.to_i }

puts '# Day 1 - Part 1:'
puts numbers.map { |n| numbers.index(2020 - n) ? 2020 - n : 1 }.reduce(&:*)

puts '# Day 1 - Part 2:'
for n in numbers
  search = 2020 - n
  for nn in numbers
    if numbers.index(search - nn)
      puts n * nn * (search - nn)
      exit
    end
  end
end