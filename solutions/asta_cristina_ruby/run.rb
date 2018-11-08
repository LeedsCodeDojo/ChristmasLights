require_relative 'trees'
require_relative 'main'
require 'colorize'

require 'pry'

file_name = ARGV[0]

result = Main.new
result.read(file_name)
puts result.draw_tree.green

