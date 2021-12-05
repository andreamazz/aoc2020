lines = File.open('data.txt', 'r').map{ |l| l.strip }

sequence = lines[0].split(',')

boards = lines[1..].each_slice(6).map { |el| { board: el.select { |line| line.length > 0 }.map { |e| e.split(' ') }, won: false } }

def check_numbers sequence, boards, return_first
  data = Marshal.load(Marshal.dump(boards))
  won = 0
  for number in sequence do
    data.each_with_index do |board, index|
      board[:board].each_with_index do |line, row|
        data[index][:board][row].each_with_index do |n, col|
          if n == number && !data[index][:won]
            data[index][:board][row][col] = '*'
            if (data[index][:board][row].reduce(&:+) == '*****') || (data[index][:board].map { |row| row[col] }.reduce(&:+) == '*****')
              won += 1
              data[index][:won] = true
              if return_first || won == data.length
                return data[index][:board].map { |line| line.map(&:to_i).reduce(&:+) }.reduce(&:+) * number.to_i
              end
            end
          end
        end
      end
    end
  end
end

puts '# Day 4 - Part 1:'
puts check_numbers(sequence, boards, true)

puts '# Day 4 - Part 2:'
puts check_numbers(sequence, boards, false)
