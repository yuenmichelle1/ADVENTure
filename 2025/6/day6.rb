require 'matrix'
require 'debug'
example_input = File.readlines('./day6_example_input.txt')
input = File.readlines('./day6_input.txt')

def part_one(input)
    input_arr = input.map { |l| l.split(' ') }

    math_sentences_matrix = Matrix[*input_arr]
    total_sum_of_answers = 0
    math_sentences_matrix.column_vectors.each do |math_sentence|
        math_sentence_arr = math_sentence.to_a
        operation = math_sentence_arr.pop
        math_sentence_result = operation == '*' ? 1 : 0
        math_sentence_arr.map(&:to_i).each do |num|
            math_sentence_result = math_sentence_result.send(operation.to_sym, num)
        end
        total_sum_of_answers += math_sentence_result
    end
    total_sum_of_answers
end

puts 'PART ONE'
puts part_one(input)


## PART TWO

input_arr = input.map { |str_line| str_line.gsub('\n', '').chars }
operations = input_arr.pop
operations.delete(' ')

input_matrix =  Matrix[*input_arr]

# nums of our math sentences as strings separating each new num of a math sentence by a ''
nums_as_strs = input_matrix.column_vectors.map do |v|
    vector_str = ''
    v.each do |char|
        vector_str += char
    end
    vector_str.strip
end

# separate numbers of different math sentences into different arrays
# eg 123 + 23 + 4 and  21 * 1 * 100 will look like [[123,23,4], [21,1,100]]
sliced_nums_of_math_sentences = nums_as_strs.slice_after { |char| char == '' }

total_sum_of_answers = 0
sliced_nums_of_math_sentences.each_with_index do |num_arr, i|
    operation = operations[i]
    math_sentence_result = operation == '*' ? 1 : 0
    num_arr.delete('')
    num_arr.map(&:to_i).each do |num|
        math_sentence_result = math_sentence_result.send(operation.to_sym, num)
    end
    total_sum_of_answers += math_sentence_result
end

puts 'PART TWO '
puts total_sum_of_answers