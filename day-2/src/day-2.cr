# Solution for Advent of Code 2024 - Day 2

t1 = Time.monotonic

file_contents = File.read("input/input.txt")
# Split by line, remove empty strings, split lines by space, convert numbers in string format to ints
reports = file_contents.split('\n').select { |x| x.size > 0 }.map { |x| x.split(' ').map { |y| y.to_i } }
safe_count = 0
reports.each do |report|
    report_sorted = report.sort
    if report != report_sorted && report != report_sorted.reverse
        next
    end
    if report.each_cons(2).sum { |x| (1..3).includes?((x[0] - x[1]).abs) ? 1 : 0 } == report.size - 1
        safe_count += 1
    end
end
puts safe_count

puts Time.monotonic - t1
