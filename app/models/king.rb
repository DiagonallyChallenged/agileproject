class King < Piece

	def valid_move?(x:, y:)
		location = {
			x: x,
			y: y,
		}

		( one_square_forward?(location) && empty_square?(location) ) || \
		( diagonal_move?(location) && enemy_occupied_square?(location) )
	end

	def one_square_forward?(location)
		location[:y] == self.y + 1 &&
		location[:x] == self.x 
	end


	def empty_square?(location)
		Piece.find_by(location).nil?
	end

	def diagonal_move?(location)
		( location[:y] == self.y + 1 ) &&
		( location[:x].in?([ self.x + 1, self.x - 1]) )
	end

end
