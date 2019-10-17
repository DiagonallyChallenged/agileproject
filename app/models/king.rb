class King < Piece
  def valid_move?(x:, y:)
    return false if obstructed?(self.x, self.y, x, y)

    location = {
      x: x,
      y: y
    }

    (one_square_forward_or_backwards?(location) && empty_square?(location)) || \
      (diagonal_move?(location) || horizontal_move?(location))
  end

  def one_square_forward_or_backwards?(location)
    location[:y].in?([y + 1, y - 1]) &&
      (location[:x] == x)
  end

  def empty_square?(location)
    Piece.find_by(location).nil?
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
