# Solution for Advent of Code 2024 - Day 4

t1 = Time.monotonic

file_contents = File.read("input/input.txt")

lines = file_contents.split('\n').select { |x| x.size > 0 }

rules = [] of Array(Int8)
updates = [] of Array(Int8)

lines.each do |line|
    if line[2] == '|'
        rules << line.split('|').map { |x| x.to_i8 }
    else
        updates << line.split(',').map { |x| x.to_i8}
    end
end

# Map any given page to a list of pages it must come before
rule_map = {} of Int8 => Set(Int8)
rules.each do |rule|
    before = rule[0]
    after = rule[1]

    if !rule_map.has_key?(before)
        rule_map[before] = Set(Int8).new
    end
    rule_map[before] << after
end

correct_updates = 0
corrected_mid_sum = 0
updates.each do |update|
    sorted = update.sort { |a, b|
        if rule_map.has_key?(a) && rule_map[a].includes?(b)
            -1
        elsif rule_map.has_key?(b) && rule_map[b].includes?(a)
            1
        else
            0
        end
    }
    if update == sorted
        correct_updates += update[update.size // 2]
    else
        corrected_mid_sum += sorted[sorted.size // 2]
    end
end

puts "#{correct_updates} page updates are already correct"
puts "#{corrected_mid_sum} is the sum of corrected update middle pages"

puts Time.monotonic - t1
