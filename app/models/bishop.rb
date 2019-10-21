class Bishop < Piece
	def valid_move?(x_des:, y_des:)
    return false if obstructed?(x, y, x_des, y_des)

    location = {
      x: x_des,
      y: y_des
    }
  end

  def one_square_diagonal(location)
    location[:y].in?([y + 1, y - 1]) &&
    location[:x].in?([x + 1, x - 1])
  end
end
