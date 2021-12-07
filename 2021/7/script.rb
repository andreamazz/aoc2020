input = File.open('data.txt', 'r').map{ |l| l.strip }.first.split(',').map(&:to_i)

fuel_costs = (input.min()..input.max()).map { |n| input.map { |x| (x - n).abs() }.reduce(&:+) }

puts '# Day 7 - Part 1:'
puts fuel_costs.min()

prebaked = {}
(input.min()..input.max()).each { |n| prebaked[n] = (1..n).reduce(&:+) }
fuel_costs = (input.min()..input.max()).map { |n| input.map { |x| prebaked[(x - n).abs()] }.compact.reduce(&:+) }
puts fuel_costs.min()
puts '# Day 7 - Part 2:'
