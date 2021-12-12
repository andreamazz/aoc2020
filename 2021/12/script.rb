input = File.open('data.txt', 'r').map{ |l| l.strip }

links = {}

input.each do |line|
  a, b = line.split('-')
  if links[a] == nil
    links[a] = []
  end
  if links[b] == nil
    links[b] = []
  end
  if b != 'start'
    links[a] << b
  end
  if a != 'start'
    links[b] << a
  end
end

paths = []

def follow links, key, chain=[], paths
  current = chain.dup
  current << key

  if links[key] != nil
    links[key].each do |node|
      if node == 'end'
        current << 'end'
        paths << current
      elsif !current.include?(node) || node.upcase == node
        follow(links, node, current, paths)
      end
    end
  end
end

follow links, 'start', [], paths

puts '# Day 12 - Part 1:'
p paths.length

def follow_allowing_one_small_cave links, key, chain=[], did_visit, paths
  current = chain.dup
  current << key

  if links[key] != nil
    links[key].each do |node|
      if node == 'end'
        current << 'end'
        paths << current
      elsif !did_visit
        follow_allowing_one_small_cave(links, node, current, (node.downcase == node && current.count(node) == 1), paths)
      elsif !current.include?(node) || node.upcase == node
        follow_allowing_one_small_cave(links, node, current, did_visit, paths)
      end
    end
  end
end

paths = []
follow_allowing_one_small_cave links, 'start', [], false, paths

puts '# Day 12 - Part 2:'
p paths.length
