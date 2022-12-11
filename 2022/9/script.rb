require 'set'

input = File.readlines('data.txt').map { |l| l.strip }

def are_far? a, b
  return Math.sqrt((a[:x] - b[:x]) ** 2 + (a[:y] - b[:y]) ** 2) >= 2
end

def run_for size, input
  visited = Set.new
  visited.add({ x: 0, y: 0 })

  knots = Array.new(size, { x: 0, y: 0 })

  input.each do |l|
    direction = l.match(/([A-Z])/)[0]
    steps = l.match(/(\d+)/)[0].to_i

    (1..steps).each do |s|
      case direction
      when 'U'
        knots[0] = { x: knots[0][:x], y: knots[0][:y] + 1 }
      when 'D'
        knots[0] = { x: knots[0][:x], y: knots[0][:y] - 1 }
      when 'L'
        knots[0] = { x: knots[0][:x] - 1, y: knots[0][:y] }
      when 'R'
        knots[0] = { x: knots[0][:x] + 1, y: knots[0][:y] }
      end

      (0..knots.size - 2).each do |i|
        if are_far? knots[i], knots[i + 1]
          if knots[i][:x] == knots[i + 1][:x]
            knots[i + 1] = { x: knots[i + 1][:x], y: knots[i][:y] > knots[i + 1][:y] ? knots[i + 1][:y] + 1 : knots[i + 1][:y] - 1  }
          elsif knots[i][:y] == knots[i + 1][:y]
            knots[i + 1] = { x: knots[i][:x] > knots[i + 1][:x] ? knots[i + 1][:x] + 1 : knots[i + 1][:x] - 1, y: knots[i + 1][:y]  }
          else
            knots[i + 1] = {
              x: knots[i][:x] > knots[i + 1][:x] ? knots[i + 1][:x] + 1 : knots[i + 1][:x] - 1,
              y: knots[i][:y] > knots[i + 1][:y] ? knots[i + 1][:y] + 1 : knots[i + 1][:y] - 1
            }
          end
        end
      end

      visited.add(knots.last)
    end
  end
  visited.size
end

puts "Part 1"
p run_for 2, input
puts "Part 2"
p run_for 10, input
