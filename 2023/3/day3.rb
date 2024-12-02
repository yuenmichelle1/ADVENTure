# frozen_string_literal: true

def part_one(input)
  sum = 0
  input.each_with_index do |l, row_i|
    l.chars.each_with_index do |c, i|
      next unless contains_special_char?(c)
      left_char = l[i - 1] if i.positive?
      sum += left_number(l, i - 1).to_i if numeric?(left_char)

      right_char = l[i + 1] if i < l.length - 1
      sum += right_number(l, i + 1).to_i if numeric?(right_char)

      line_above = input[row_i - 1] if row_i.positive?
      unless line_above.nil?
        top_char = line_above[i]
        top_left_char = line_above[i - 1] if i.positive?
        top_right_char = line_above[i + 1] if i < l.length - 1

        if numeric?(top_char) && numeric?(top_left_char) && !numeric?(top_right_char)
          sum += left_number(line_above, i).to_i
        end

        sum += left_number(line_above, i - 1).to_i if !numeric?(top_char) && numeric?(top_left_char)

        if numeric?(top_char) && !numeric?(top_left_char) && numeric?(top_right_char)
          sum += right_number(line_above,
                              i).to_i
        end
        sum += right_number(line_above, i + 1).to_i if !numeric?(top_char) && numeric?(top_right_char)
        sum += top_char.to_i if numeric?(top_char) && !numeric?(top_left_char) && !numeric?(top_right_char)
        if numeric?(top_char) && numeric?(top_left_char) && numeric?(top_right_char)
          sum += middle_number(line_above, i).to_i
        end
      end

      line_below = input[row_i + 1] if row_i < input.length - 1
      next if line_below.nil?

      bottom_char = line_below[i]
      bottom_left_char = line_below[i - 1] if i.positive?
      bottom_right_char = line_below[i + 1] if i < l.length - 1

      if numeric?(bottom_char) && numeric?(bottom_left_char) && !numeric?(bottom_right_char)
        sum += left_number(line_below,
                           i).to_i
      end
      sum += left_number(line_below, i - 1).to_i if !numeric?(bottom_char) && numeric?(bottom_left_char)
      if numeric?(bottom_char) && !numeric?(bottom_left_char) && numeric?(bottom_right_char)
        sum += right_number(line_below,
                            i).to_i
      end
      sum += right_number(line_below, i + 1).to_i if !numeric?(bottom_char) && numeric?(bottom_right_char)
      sum += bottom_char.to_i if numeric?(bottom_char) && !numeric?(bottom_left_char) && !numeric?(bottom_right_char)
      if numeric?(bottom_char) && numeric?(bottom_left_char) && numeric?(bottom_right_char)
        sum += middle_number(line_below, i).to_i
      end
    end
  end
  sum
end

def part_two(input)
  sum = 0
  input.each_with_index do |l, row_i|
    next if l.nil?

    l.chars.each_with_index do |c, i|
      next unless contains_star? c
      adjacent_nums = []

      left_char = l[i - 1] if i.positive?
      adjacent_nums << left_number(l, i - 1).to_i if numeric?(left_char)

      right_char = l[i + 1] if i < l.length - 1
      adjacent_nums << right_number(l, i + 1).to_i if numeric?(right_char)

      line_above = input[row_i - 1] if row_i.positive?
      unless line_above.nil?
        top_char = line_above[i]
        top_left_char = line_above[i - 1] if i.positive?
        top_right_char = line_above[i + 1] if i < l.length - 1
        if numeric?(top_char) && numeric?(top_left_char) && !numeric?(top_right_char)
          adjacent_nums << left_number(line_above, i).to_i
        end
        adjacent_nums << left_number(line_above, i - 1).to_i if !numeric?(top_char) && numeric?(top_left_char)

        if numeric?(top_char) && !numeric?(top_left_char) && numeric?(top_right_char)
          adjacent_nums << right_number(line_above,
                                        i).to_i
        end
        adjacent_nums << right_number(line_above, i + 1).to_i if !numeric?(top_char) && numeric?(top_right_char)
        adjacent_nums << top_char.to_i if numeric?(top_char) && !numeric?(top_left_char) && !numeric?(top_right_char)
        if numeric?(top_char) && numeric?(top_left_char) && numeric?(top_right_char)
          adjacent_nums << middle_number(line_above, i).to_i
        end
      end

      line_below = input[row_i + 1] if row_i < input.length - 1
      next if line_below.nil?

      bottom_char = line_below[i]
      bottom_left_char = line_below[i - 1] if i.positive?
      bottom_right_char = line_below[i + 1] if i < l.length - 1

      if numeric?(bottom_char) && numeric?(bottom_left_char) && !numeric?(bottom_right_char)
        adjacent_nums << left_number(line_below,
                                     i).to_i
      end
      adjacent_nums << left_number(line_below, i - 1).to_i if !numeric?(bottom_char) && numeric?(bottom_left_char)
      if numeric?(bottom_char) && !numeric?(bottom_left_char) && numeric?(bottom_right_char)
        adjacent_nums << right_number(line_below,
                                      i).to_i
      end
      adjacent_nums << right_number(line_below, i + 1).to_i if !numeric?(bottom_char) && numeric?(bottom_right_char)
      if numeric?(bottom_char) && !numeric?(bottom_left_char) && !numeric?(bottom_right_char)
        adjacent_nums << bottom_char.to_i
      end

      if numeric?(bottom_char) && numeric?(bottom_left_char) && numeric?(bottom_right_char)
        adjacent_nums << middle_number(line_below, i).to_i
      end

      sum += adjacent_nums.inject(:*) if adjacent_nums.length == 2
    end
  end
  sum
end

def contains_star?(str)
  str.scan('*').length.positive?
end

def contains_special_char?(str)
  return false if str.nil?

  special_chars = "?<>',?[]}{=-)(*&^%$#`~{}/+@"
  regex_to_check = /[#{special_chars.gsub(/./) { |char| "\\#{char}" }}]/
  !(str =~ regex_to_check).nil?
end

def right_number(line, start_index)
  num = line[start_index]
  while start_index < line.length - 1
    break unless numeric? line[start_index + 1]

    num += line[start_index + 1]
    start_index += 1
  end
  num
end

def left_number(line, start_index)
  num = line[start_index]
  while start_index.positive?
    break unless numeric? line[start_index - 1]

    num.prepend(line[start_index - 1])
    start_index -= 1
  end
  num
end

def middle_number(line, start_index)
  right_part = right_number(line, start_index).to_s
  left_part = left_number(line, start_index).to_s
  (left_part.chop + right_part)
end

def numeric?(look_ahead)
  return false if look_ahead.nil?

  look_ahead.match?(/\d+/)
end

input = File.readlines('./day3_input.txt')

puts(part_one(input))
puts(part_two(input))