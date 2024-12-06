# Solution for Advent of Code 2024 - Day 4

t1 = Time.monotonic

file_contents = File.read("input/input.txt")

lines = file_contents.split('\n').select { |x| x.size > 0 }

rules = [] of String
updates = [] of Array(String)

lines.each do |line|
    if line.includes?('|')
        rules << line
    else
        updates << line.split(',')
    end
end

# Map any given page to a list of pages it must come before
rule_map = {} of String => Array(String)
rules.each do |rule|
    before = rule.split('|')[0]
    after = rule.split('|')[1]

    if !rule_map.keys.includes?(before)
        rule_map[before] = Array(String).new
    end
    rule_map[before] << after
    rule_map[before].sort!
end

correct_updates = 0
corrected_mid_sum = 0
updates.each do |update|
    sorted = update.sort { |a, b|
        if rule_map.keys.includes?(a) && rule_map[a].includes?(b)
            -1
        elsif rule_map.keys.includes?(b) && rule_map[b].includes?(a)
            1
        else
            0
        end
    }
    if update == sorted
        correct_updates += update[update.size // 2].to_i
    else
        corrected_mid_sum += sorted[sorted.size // 2].to_i
    end
end

puts "#{correct_updates} page updates are already correct"
puts "#{corrected_mid_sum} is the sum of corrected update middle pages"

puts Time.monotonic - t1
