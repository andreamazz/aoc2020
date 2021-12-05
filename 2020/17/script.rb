groups = File.readlines('data.txt', "\n\n").map(&:rstrip)

rules = {}
groups.first.split("\n").each do |rule|
  rules[rule.split(':').first] = rule.split(':').last.scan(/\d+-\d+/).flatten
end

my_ticket = groups[1].split("\n")[1].split(',').map(&:to_i)

nearby = groups.last

def check_rules rules, ticket
  ticket.split(',').map(&:to_i).map do |n|
    rules.values.flatten.map { |r| n < r.split('-').first.to_i || n > r.split('-').last.to_i }.reduce(&:&) ? n : 0
  end
end

puts '# Day 16 - Part 1:'
puts nearby.split("\n")[1..].map { |t| check_rules(rules, t) }.flatten.reduce(&:+)

valid = nearby.split("\n")[1..].filter { |t| check_rules(rules, t).reduce(&:+) == 0 }.map { |v| v.split(',').map(&:to_i) }
mapping = {}

while mapping.keys.size < (valid.first.size - 1) do
  for i in (0..(valid.first.size - 1))
    possible = []
    for key in rules.keys
      ruleset = rules[key].flatten
      if valid.map { |v| v[i] }.map { |n| ruleset.map { |r| n >= r.split('-').first.to_i && n <= r.split('-').last.to_i }.reduce { |a, b| a || b } }.reduce(&:&)
        possible.append({ key: key, index: i })
      end
    end
    if possible.size == 1
      mapping[possible.first[:key]] = possible.first[:index]
      rules.delete(possible.first[:key])
    end
  end
end

puts '# Day 16 - Part 2:'
puts mapping.keys.filter { |k| k.start_with? 'departure' }.map { |k| my_ticket[mapping[k]] }.reduce(&:*)
