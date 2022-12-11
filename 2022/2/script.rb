batches = File.readlines('data.txt')

SCORE = { X: 1, Y: 2, Z: 3, A: 1, B: 2, C: 3 }

def check pair
  a, b = pair.split
  score = SCORE[b.to_sym]

  case [a, b]
  when -> (tuple) { SCORE[tuple[0].to_sym] == SCORE[tuple[1].to_sym] }
    score += 3
  when -> (tuple) { (tuple[0] == 'A' && tuple[1] == 'Y') || (tuple[0] == 'B' && tuple[1] == 'Z') || (tuple[0] == 'C' && tuple[1] == 'X') }
    score += 6
  end
  score
end

scores = batches.map { |pair| check(pair) }

puts "Part 1"
puts scores.reduce(&:+)

RESULTS = { X: { A: :Z, B: :X, C: :Y }, Y: { A: :X, B: :Y, C: :Z }, Z: { A: :Y, B: :Z, C: :X } }
POINTS = { X: 0, Y: 3, Z: 6 }

def check_2 pair
  a, b = pair.split
  POINTS[b.to_sym] + SCORE[RESULTS[b.to_sym][a.to_sym]]
end

scores = batches.map { |pair| check_2(pair) }

puts "Part 2"
puts scores.reduce(&:+)