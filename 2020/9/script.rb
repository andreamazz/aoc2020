numbers = File.open('data.txt', 'r').map{ |l| l.strip.to_i }
preamble_size = 25

odd_one_out = nil
for i in (preamble_size..numbers.size - 1)
  window = numbers[((i - preamble_size)..(i - 1))]
  # puts "#{numbers[i]} - #{window}"
  if window.map { |n| window.include?(numbers[i] - n) }.reduce(&:|) == false
    odd_one_out = numbers[i]
    break
  end
end

def get_sum_elements(numbers, value)
  for i in (0..numbers.size)
    sum = 0
    elements = []
    for j in (i..numbers.size)
      sum += numbers[j]
      elements << numbers[j]
      if sum == value
        return elements
      elsif sum > value
        break
      end
    end
  end
end

puts '# Day 9 - Part 1:'
puts odd_one_out
puts '# Day 9 - Part 2:'
elements = get_sum_elements(numbers, odd_one_out)
puts elements.min + elements.max
