passports = File.readlines('data.txt', "\n\n").map(&:rstrip)

def valid string, use_strict_rules
  rules = {
    byr: /\b(byr:(19[2-8][0-9]|199[0-9]|200[0-2]))\b/,
    iyr: /\b(iyr:(201[0-9]|2020))\b/,
    eyr: /\b(eyr:(202[0-9]|2030))\b/,
    hgt: /\b(hgt:(1[5-8][0-9]|19[0-3])cm|hgt:(59|6[0-9]|7[0-6])in)\b/,
    hcl: /\b(hcl:#[a-f0-9]{6})\b/,
    ecl: /\b((ecl:amb)|(ecl:blu)|(ecl:brn)|(ecl:gry)|(ecl:grn)|(ecl:hzl)|(ecl:oth))\b/,
    pid: /\b(pid:\d{9})\b/
  }

  if use_strict_rules
    rules.keys.map{ |r| string.match(rules[r]) != nil }.reduce { |a,b| a && b }
  else
    has_fields = rules.keys.map { |k| string.index("#{k.to_s}:") != nil }.reduce { |a,b| a && b }
  end
end

puts '# Day 4 - Part 1:'
puts passports.map { |p| valid(p, false) }.inject(0) { |count, i| count += i ? 1 : 0 }
puts '# Day 4 - Part 2:'
puts passports.map { |p| valid(p, true) }.inject(0) { |count, i| count += i ? 1 : 0 }