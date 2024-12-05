require 'matrix'
# input = File.readlines('./day4_input.txt')
input = File.readlines('./day4_input.txt')
input_arr = input.map { |str_line| str_line.gsub("\n", '').chars }

input_matrix = Matrix[*input_arr]

def find_xmas(xmas_count, line_arr)
  line_arr.each do |line|
    xmas_count += line.scan(/XMAS/).length
    xmas_count += line.reverse.scan(/XMAS/).length
  end
end

xmas_count = 0
# horizontal
input.each do |line|
  xmas_count += line.scan(/XMAS/).length
  xmas_count += line.reverse.scan(/XMAS/).length
end

# columns
transposed_input_matrix = input_matrix.transpose.to_a
transposed_input_matrix.each do |column_arr|
  xmas_count += column_arr.join.scan(/XMAS/).length
  xmas_count += column_arr.reverse.join.scan(/XMAS/).length
end


# diagonals
diagonals = []

def get_diagonal_words(counter, diagonals, input_arr)
  word_lr = ''
  word_rl = ''
  return unless counter < input_arr.length - 1

  input_arr.each_with_index do |line, i|
    reversed_line = line.reverse
    word_lr += line[i + counter] unless line[i + counter].nil?
    word_rl += reversed_line[i + counter] unless reversed_line[i + counter].nil?
  end
  diagonals << word_lr
  diagonals << word_rl
  counter += 1
  get_diagonal_words(counter, diagonals, input_arr)
end

counter = 0
get_diagonal_words(counter, diagonals, input_arr)
puts xmas_count
reverse_arr_counter = 0
get_diagonal_words(reverse_arr_counter, diagonals, input_arr.reverse)


diagonals.each do |line|
  # skip the true diagonals M[i,j] where i = j or M[i, j] where i + j = n where M is a n x n matrix,
  #  and deal with those separately to avoid double counting
  next if line.length == input_arr.length

  xmas_count += line.scan(/XMAS/).length
  xmas_count += line.reverse.scan(/XMAS/).length
end

xmas_count += diagonals[0].scan(/XMAS/).length
xmas_count += diagonals[0].reverse.scan(/XMAS/).length
xmas_count += diagonals[1].scan(/XMAS/).length
xmas_count += diagonals[1].reverse.scan(/XMAS/).length
puts xmas_count