class Bishop < Piece
  def valid_move?(x_des:, y_des:)
    return false if obstructed?(x, y, x_des, y_des)

    location = {
      x: x_des,
      y: y_des
    }

    diagonal_move?(location)
  end

  def diagonal_move?(location)
    x_des = location[:x]
    y_des = location[:y]
    x_distance = (x_location - x_des).abs
    y_distance = (y_location - y_des).abs

    x_distance == y_distance
  end
end
