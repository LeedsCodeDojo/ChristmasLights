require_relative 'trees'

class Main
  attr_reader :listing

	def read(file_name)
    @listing = File.readlines(file_name).map(&:chomp)
  end

  def draw_tree
    size = /TREE \((\d+),(\d+)\)/i.match(listing.shift)
    return unless size

    @tree = Trees.new(size[1].to_i, size[2].to_i)
    
    listing.each do |line|
      match = /(ON|OFF|TOGGLE) \((\d+),(\d+)\)\((\d+),(\d+)\)/i.match(line)
      next unless match

      pars = match[2,5].map(&:to_i)
      @tree.send(match[1].downcase, *pars)
    end
    @tree.draw
  end
end