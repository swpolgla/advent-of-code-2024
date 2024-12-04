# Solution for Advent of Code 2024 - Day 4
# This is the worst thing I've ever submitted for advent of code

t1 = Time.monotonic

file_contents = File.read("input/input.txt")

lines = file_contents.split('\n').select { |x| x.size > 0 }

# Horizontal is easy :)
horizontal_matches = lines.sum { |line| line.scan(/(XMAS)|(SAMX)/).size }

# Vertical is medium :|
vertical_lines = Array(String).new
(lines[0].size - 1).times do |x|
    vertical_lines << ""
    (lines.size - 1).times do |y|
        # puts "#{x}, #{y}"
        vertical_lines[x] = vertical_lines[x] + lines[y][x]
    end
end
vertical_matches = vertical_lines.sum { |line| line.scan(/(XMAS)|(SAMX)/).size }

# Diagonal is to go... even further... BEYOND >:(
#  * X *
#  X * *
#  * * *
diagonal_left_left_lines = Array(String).new
#  * * *
#  * * X
#  * X *
diagonal_left_right_lines = Array(String).new
#  * X *
#  * * X
#  * * *
diagonal_right_left_lines = Array(String).new
#  * * *
#  X * *
#  * X *
diagonal_right_right_lines = Array(String).new
(lines.size - 1).times do |x|
    diagonal_left_left_lines << ""
    diagonal_left_right_lines << ""
    diagonal_right_left_lines << ""
    diagonal_right_right_lines << ""

    # Top Left Corner <-> Bottom Right Corner Diagonals
    (0..x).each do |y|
        z = x - y # AHHHHHHHHHHHH >:0
        # Top Left Corner -> Center
        diagonal_left_left_lines[x] = diagonal_left_left_lines[x] + lines[z][y]
        # Bottom Right Corner -> Center
        diagonal_left_right_lines[x] = diagonal_left_right_lines[x] + lines[(lines.size-1)-z][(lines.size-1)-y]

    end

    (x..(lines.size-1)).each do |y|
        z = y - x # 0:< HHHHHHHHHHHHA
        # puts "x: #{z}, y: #{y}"
        diagonal_right_right_lines[x] = diagonal_right_right_lines[x] + lines[z][y]
        diagonal_right_left_lines[x] = diagonal_right_left_lines[x] + lines[(lines.size-1)-z][(lines.size-1)-y]
    end
end

left_center = ""
140.times do |x|
    left_center = left_center + lines[x][x]
end
# diagonal_left_left_lines << left_center

diagonal_left_left_matches = diagonal_left_left_lines.sum { |line| line.scan(/(XMAS)|(SAMX)/).size }
diagonal_left_right_matches = diagonal_left_right_lines.sum { |line| line.scan(/(XMAS)|(SAMX)/).size }
diagonal_right_left_matches = diagonal_right_left_lines.sum { |line| line.scan(/(XMAS)|(SAMX)/).size }
diagonal_right_right_matches = diagonal_right_right_lines.sum { |line| line.scan(/(XMAS)|(SAMX)/).size }
diagonal_matches = diagonal_left_left_matches + diagonal_left_right_matches + diagonal_right_left_matches + diagonal_right_right_matches

# puts diagonal_left_left_lines
# puts diagonal_left_right_lines
# puts diagonal_right_left_lines
# puts diagonal_right_right_lines


puts "horizontal: #{horizontal_matches}"
puts "vertical: #{vertical_matches}"
puts "diagonal: #{diagonal_matches}"
puts "sum: #{horizontal_matches + vertical_matches + diagonal_matches}"

# Part 2

xmas_count = 0
lines.each_with_index do |line, x|
    if [0, lines.size-1].includes?(x)
        next
    end
    line.each_char_with_index do |ch, y|
        if [0, lines.size-1].includes?(y)
            next
        end
        if ch == 'A'
            ld = "#{lines[x-1][y+1]}#{ch}#{lines[x+1][y-1]}"
            rd = "#{lines[x-1][y-1]}#{ch}#{lines[x+1][y+1]}"
            if (ld == "MAS" || ld == "SAM") && (rd == "MAS" || rd == "SAM")
                xmas_count += 1
            end
        end
    end
end
puts "xmas: #{xmas_count}"

puts Time.monotonic - t1
