lines = File.open('data.txt', 'r').map{ |l| l.strip }

def pass_to_id pass
  row = pass[..-4].gsub('B', '1').gsub('F', '0').to_i(2)
  col = pass[-3..].gsub('R', '1').gsub('L', '0').to_i(2)
  row * 8 + col
end

def find_seat ids
  for i in (0..ids.size)
    if i < ids.size - 2 && ids[i + 1] - ids[i] > 1
      return ids[i] + 1
    end
  end
end

ids = lines.map { |l| pass_to_id(l) }

puts '# Day 5 - Part 1:'
puts ids.max
puts '# Day 5 - Part 2:'
puts find_seat ids.sort
