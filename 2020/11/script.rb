lines = File.open('data.txt', 'r').map{ |l| l.strip }

def seat_for_neighbor data, row, col
  row < 0 || row > data.size - 1 || col < 0 || col > data[0].size ? nil : data[row][col]
end

def check_neighbors data, row, col
  [
    [row - 1, col - 1], [row, col - 1], [row + 1, col - 1],
    [row - 1, col], [row + 1, col],
    [row - 1, col + 1], [row, col + 1], [row + 1, col + 1]
  ].map { |seat| seat_for_neighbor(data, seat[0], seat[1]) }.compact.map { |seat| seat == '#' ? 1 : 0 }.reduce(&:+)
end

def line_of_sight data, row, col, dx, dy
  seat = seat_for_neighbor(data, row + dx, col + dy)
  if !seat || seat != '.'
    seat
  else
    line_of_sight(data, row + dx, col + dy, dx, dy)
  end
end

def sight_neighbors data, row, col
  [
    [-1, -1], [0, -1], [1, -1],
    [-1, 0], [1, 0],
    [-1, 1], [0, 1], [1, 1]
  ].map { |delta| line_of_sight(data, row, col, delta[0], delta[1]) }.compact.map { |seat| seat == '#' ? 1 : 0 }.reduce(&:+)
end

def seats_from data, use_line_of_sight
  seats = Marshal.load(Marshal.dump(data))
  loop do
    limit = use_line_of_sight ? 5 : 4
    copy = Marshal.load(Marshal.dump(seats))
    for row in (0..seats.size - 1)
      for col in (0..seats[row].size - 1)
        neighbors_occupied = use_line_of_sight ? sight_neighbors(copy, row, col) : check_neighbors(copy, row, col)
        case seats[row][col]
        when 'L'
          seats[row][col] = neighbors_occupied > 0 ? 'L' : '#'
        when '#'
          seats[row][col] = neighbors_occupied >= limit ? 'L' : '#'
        end
      end
    end
    break if copy == seats
  end
  seats.map { |l| l.count('#') }.reduce(&:+)
end

puts '# Day 11 - Part 1:'
puts seats_from(lines, false)
puts '# Day 11 - Part 2:'
puts seats_from(lines, true)