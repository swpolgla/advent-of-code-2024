# Solution for Advent of Code 2024 - Day 2

t1 = Time.monotonic

file_contents = File.read("input/input.txt")
# Split by line, remove empty strings, split lines by space, convert numbers in string format to ints
reports = file_contents.split('\n').select { |x| x.size > 0 }.map { |x| x.split(' ').map { |y| y.to_i } }

def asc_or_dec(list : Array(Int32))
    list_sorted = list.sort
    return list == list_sorted || list == list_sorted.reverse
end

def diff_check(list : Array(Int32))
    return list.each_cons(2).sum { |x| (1..3).includes?((x[0] - x[1]).abs) ? 1 : 0 } == list.size - 1
end

# Part 1
safe_count = 0
kinda_safe_count = 0
p1_reports = reports.clone
reports.each do |report|
    if asc_or_dec(report) && diff_check(report)
        safe_count += 1
    else
        # Part 2
        report.each_with_index do |x, idx|
            fake_report = report.clone
            fake_report.delete_at(idx)
            if asc_or_dec(fake_report) && diff_check(fake_report)
                kinda_safe_count += 1
                break
            end
        end
    end
end
puts "Completely Safe Reports: #{safe_count}"
puts "Kinda Safe Reports: #{kinda_safe_count}"
puts "Total 'Safe' Reports: #{safe_count + kinda_safe_count}"

puts Time.monotonic - t1
