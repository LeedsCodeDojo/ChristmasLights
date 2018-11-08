require 'pry'
class Trees
	attr_reader :width, :height, :grid

	def initialize(width, height)
		@width = width
		@height = height
		@grid = Array.new(height).collect { |e| Array.new(width, '*') }
	end

	def draw()
	  return grid.map { |r| r.join }
	  			 .join("\n")
	end

	def off(top, left, bottom, right)
    top, bottom = bottom, top if bottom < top
    left, right = right, left if right < left
	  top.upto(bottom) do |x|
	  	left.upto(right) do |y|
	  		grid[x][y] = ' '
	  	end
	  end
	end

  def toggle(top, left, bottom, right)
    top, bottom = bottom, top if bottom < top
    left, right = right, left if right < left
    top.upto(bottom) do |x|
      left.upto(right) do |y|
        grid[x][y] = grid[x][y] === ' ' ? '*' : ' ' 
      end
    end
  end

  def on(top, left, bottom, right)
    top, bottom = bottom, top if bottom < top
    left, right = right, left if right < left
    top.upto(bottom) do |x|
      left.upto(right) do |y|
        grid[x][y] = '*'
      end
    end
  end

end