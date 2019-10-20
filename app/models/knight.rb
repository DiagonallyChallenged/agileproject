class Knight < Piece
  def valid_move?(x_des:, y_des:)
    x_distance = (x_location - x_des).abs
    y_distance = (y_location - y_des).abs

    return true if x_distance == 2 && y_distance == 1 || x_distance == 1 && y_distance == 2

    false
  end
end
