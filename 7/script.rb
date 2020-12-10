rules = File.open('data.txt', 'r').map{ |l| l.strip }

relationships = {}

rules.each do |r|
  color = r.match(/^(.+?)(?=\sbag)/)[0]
  bags = r.scan(/(\d.+?)(?=\sbag)/).flatten

  relationships[color] = Hash[
    bags.map do |b|
      items = b.scan(/(\d)(.+)/).flatten
      key = items[1].strip
      value = items[0].to_i
      [key, value]
    end.to_h
  ]
end

def search color, in_bag, relationships
  values = []
  relationships[in_bag].keys.each do |bag|
    if bag == color || search(color, bag, relationships).size > 0
      values << [in_bag]
    end
  end
  values.flatten
end

def count_in color, relationships
  return 1 if relationships[color].keys.size == 0
  relationships[color].keys.map { |b| count_in(b, relationships) * relationships[color][b] }.reduce(&:+) + 1
end


puts '# Day 7 - Part 1:'
puts relationships.keys.map { |k| search('shiny gold', k, relationships) }.flatten.uniq.size
puts '# Day 7 - Part 2:'
puts count_in('shiny gold', relationships) - 1 # The bag we are searching for is counted