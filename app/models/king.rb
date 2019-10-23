class King < Piece
  def valid_move?(x_des:, y_des:)
    return false if obstructed?(x, y, x_des, y_des)

    location = {
      x: x_des,
      y: y_des
    }

    one_square_forward_or_backwards?(location) || \
      (diagonal_move?(location) || horizontal_move?(location))
  end

  def one_square_forward_or_backwards?(location)
    location[:y].in?([y + 1, y - 1]) &&
      (location[:x] == x)
  end

  def diagonal_move?(location)
    location[:y].in?([y + 1, y - 1]) &&
      location[:x].in?([x + 1, x - 1])
  end

  def horizontal_move?(location)
    (location[:y] == y) &&
      location[:x].in?([x + 1, x - 1])
  end
end
