numbers = File.open('data.txt', 'r').map{ |l| l.strip.to_i }

def increases_for_array arr
  increases = 0
  arr.each_cons(2) do |(a, b)|
    if b > a
      increases += 1
    end
  end
  increases
end

puts '# Day 1 - Part 1:'
puts increases_for_array numbers

sums = []
numbers.each_cons(3) do |(a, b, c)|
  sums << (a + b + c)
end

puts '# Day 1 - Part 2:'
puts increases_for_array sums
