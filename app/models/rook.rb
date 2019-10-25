class Rook < Piece
  def valid_move?(x_des:, y_des:)
    return false if obstructed?(x, y, x_des, y_des)

    return true if x == x_des || y == y_des

    false
  end
end
