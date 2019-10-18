class Knight < Piece

  def valid_move?(x_des:, y_des:)
    location = {
      x: x_des,
      y: y_des
    }
  end
end
