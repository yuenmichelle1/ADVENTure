# frozen_string_literal: true

class Directory
  attr_reader :children, :parent

  def initialize(parent)
    @children = []
    @parent = parent
  end

  def add_child(child)
    @children << child
  end
end

directory = Directory.new
File.read('test_input.txt').split("\n").each do |line|
   current_folder = "/"
  if line.start_with?('$')
    command, folder_name = line.tr('$',' ').split
    next if command == 'ls'
    if folder_name == ".."
        # current_folder = 
    end
  end
#   puts directory
end
# arr.each do |line|
# end

## WANT

# {
#     /: {
#         a: {
#           e: {
#             i: 584
#           },
#           f: 29116,
#           g: 2557,
#           h_lst: 62596
#         },
#         b_txt: 14848514,
#         c_dat: 8504156,
#         d: {
#             j: 4060174,
#             d_log: 8033020,
#             d_ext: 5626152,
#             k: 7214296
#         }
#     }
# }
