class King < Piece

	def valid_move?(x:, y:)
    if obstructed?(self.x, self.y, x, y)
      return false
    end
		location = {
			x: x,
			y: y,
		}

		( one_square_forward_or_backwards?(location) && empty_square?(location) ) || \
		( diagonal_move?(location) || horizontal_move?(location) )
	end

	def one_square_forward_or_backwards?(location)
    ( location[:y].in?([ self.y + 1, self.y - 1]) ) &&
		( location[:x] == self.x )
	end


	def empty_square?(location)
		Piece.find_by(location).nil?
	end

	def diagonal_move?(location)
		( location[:y].in?([ self.y + 1, self.y - 1]) ) &&
		( location[:x].in?([ self.x + 1, self.x - 1]) ) 
	end

  def horizontal_move?(location)
    ( location[:y] == self.y ) &&
    ( location[:x].in?([ self.x + 1, self.x - 1]) )
  end

end

