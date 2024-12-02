# frozen_string_literal: true

def numeric?(look_ahead)
  look_ahead.to_i.to_s == look_ahead
end

def stack_hash_map(sketch)
  stacks_without_parens = sketch.split("\n").map { |row| row.tr('[]', ' ').scan(/.{1,4}/) }
  stacks_hash = {}
  stacks_without_parens.reverse.each do |row|
    row.each_with_index do |entry, i|
      entry = entry.strip
      next if entry.empty? || numeric?(entry)

      stacks_hash[(i + 1).to_s] = if stacks_hash.key?((i + 1).to_s)
                                    stacks_hash[(i + 1).to_s].append(entry)
                                  else
                                    [entry]
                                  end
    end
  end
  stacks_hash
end

def top_of_stacks(stack_hash)
  top = []
  stack_hash.each_value { |stack| top << stack[-1] }
  top.join
end

def parse_instructions(instructions)
  instructions.split("\n").map do |instruction|
    instruction.split(' ').filter do |letter|
      numeric? letter
    end.map(&:to_i)
  end
end

def new_from_row(stacks_in_from_row, num_to_move)
  stacks_in_from_row.take(stacks_in_from_row.length - num_to_move)
end

def set_new_cols(new_from_row, stacks_hash, from_row_num, to_row_num, stacks_to_move)
  stacks_hash[from_row_num.to_s] = new_from_row
  stacks_in_to_row = stacks_hash[to_row_num.to_s].concat(stacks_to_move)
  stacks_hash[to_row_num.to_s] = stacks_in_to_row
end

def do_instructions(instructions, stacks_hash)
  instructions_arr = parse_instructions instructions
  instructions_arr.each do |instruction|
    num_to_move, from_row_num, to_row_num = instruction
    stacks_in_from_row = stacks_hash[from_row_num.to_s]
    stacks_to_move = stacks_in_from_row.reverse.take(num_to_move)
    new_from_row = new_from_row stacks_in_from_row, num_to_move
    set_new_cols new_from_row, stacks_hash, from_row_num, to_row_num, stacks_to_move
  end
  top_of_stacks(stacks_hash)
end

def do_crane_two_instructions(instructions, stacks_hash)
  instructions_arr = parse_instructions instructions
  instructions_arr.each do |instruction|
    num_to_move, from_row_num, to_row_num = instruction
    stacks_in_from_row = stacks_hash[from_row_num.to_s]
    stacks_to_move = stacks_in_from_row.reverse.take(num_to_move).reverse
    new_from_row = new_from_row stacks_in_from_row, num_to_move
    set_new_cols new_from_row, stacks_hash, from_row_num, to_row_num, stacks_to_move
  end
  top_of_stacks(stacks_hash)
end

sketch, instructions = File.read('./input.txt').split("\n\n")

puts do_instructions(instructions, stack_hash_map(sketch))
puts do_crane_two_instructions(instructions, stack_hash_map(sketch))
