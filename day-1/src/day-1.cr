# Solution for Advent of Code 2024 - Day 1

t1 = Time.monotonic

file_contents = File.read("input/input.txt")
flat = file_contents.gsub(/\s+/, ' ').split(' ').select { |x| x.size > 0 }
left_column = flat.each_step(2).map { |x| x.to_i32 }.to_a.sort
right_column = flat.each_step(2, offset: 1).map { |x| x.to_i32 }.to_a.sort

# Part 1
total_distance = left_column.zip(right_column).sum { |x| (x[0] - x[1]).abs }
puts "Part 1 Total Distance: #{ total_distance }"

# Part 2
puts "Part 2 Similarity Score: #{ left_column.sum { |x| x * right_column.count(x) } }"

puts Time.monotonic - t1
