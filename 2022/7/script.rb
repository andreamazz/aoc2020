input = File.readlines('data.txt')

path = []
fs = {}

def add_size fs, path, size
  if fs[path]
    fs[path] += size
  else
    fs[path] = size
  end
end

input.each do |line|
  cd = line.match /\$\scd\s(.+)/
  if cd
    if cd[1] == '..'
      path.pop
    elsif cd[1] == '/'
      path = ['/']
    else
      path.push "#{cd[1]}/"
    end
  end
  size = line.match /\d+/
  if size
    full_path = path.join
    add_size fs, full_path, size[0].to_i
    if path.size > 1
      path[(1..path.size-1)].reverse.each do |p|
        full_path = full_path.delete_suffix(p)
        add_size fs, full_path, size[0].to_i
      end
    end
  end
end

free_space = 70000000 - fs['/']
required_space = 30000000 - free_space

puts "Part 1"
p fs.select { |path| fs[path] < 100000 }.values.reduce(&:+)
puts "Part 2"
p fs.select { |path| fs[path] > required_space }.values.min
