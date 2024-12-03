# Solution for Advent of Code 2024 - Day 3

t1 = Time.monotonic

file_contents = File.read("input/input.txt")

p1_sum = 0
p2_sum = 0
enabled = true

mul_matches = file_contents.scan(/(mul\(\d{1,3},\d{1,3}\))|(do\(\))|(don't\(\))/)
mul_matches.each do |match|
    match = match.to_s
    if match.starts_with?("mul")
        nums = match.to_s.split(',')
        mul = nums[0].tr("^0-9", "").to_i * nums[1].tr("^0-9", "").to_i
        p1_sum += mul
        if enabled
            p2_sum += mul
        end
    elsif match.starts_with?("don't")
        enabled = false
    elsif match.starts_with?("do")
        enabled = true
    end
end
puts "Part 1 Sum: #{p1_sum}"
puts "Part 2 Sum: #{p2_sum}"

puts Time.monotonic - t1
