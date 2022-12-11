require 'set'

$input = File.read('data.txt').split("\n\n").map do |block|
  {
    items: block.scan(/(?:items:\s|,\s)(\d+)/).to_a.flatten.map(&:to_i),
    op: block.scan(/(old.+)/)[0][0],
    div: block.scan(/divisible\sby\s(\d+)/)[0][0].to_i,
    t: block.scan(/If true.+(\d)/)[0][0].to_i,
    f: block.scan(/If false.+(\d)/)[0][0].to_i
  }
end

lcm = $input.map { |m| m[:div] }.reduce(&:*)

def run times, divisor, modulo
  monkeys = Marshal.load(Marshal.dump($input))

  counts = Array.new(monkeys.size, 0)
  (1..times).each do |i|
    monkeys.each_with_index do |monkey, j|
      items = monkey[:items]
      for item in items do
        counts[j] += 1
        value = (eval(monkey[:op].gsub('old', item.to_s)) / divisor) % modulo
        if value % monkey[:div] == 0
          monkeys[monkey[:t]][:items].push(value)
        else
          monkeys[monkey[:f]][:items].push(value)
        end
      end
      monkey[:items] = []
    end
  end
  counts.max(2).reduce(&:*)
end

puts "Part 1"
p run 20, 3, Float::INFINITY
puts "Part 2"
p run 10000, 1, lcm
