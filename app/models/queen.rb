class Queen < Piece
  def valid_move?(x_des, y_des)
    return false if obstructed?(x, y, x_des, y_des)

    location = {
      x: x_des,
      y: y_des
    }

    vertical_move?(location) || horizontal_move?(location) || diagonal_move?(location)
  end

  # rubocop:disable Metrics/MethodLength, Metrics/AbcSize

  def diagonal_move?(location)
    diagonal_moves.include?([location[:x], location[:y]])
  end

  def vertical_move?(location)
    vertical_moves.include?([location[:x], location[:y]])
  end

  def horizontal_move?(location)
    horizontal_moves.include?([location[:x], location[:y]])
  end

  def diagonal_moves
    moves = []

    (1..8).each do |i|
      moves.push([x - i, y - i])
    end

    (1..8).each do |i|
      moves.push([x - i, y + i])
    end

    (1..8).each do |i|
      moves.push([x + i, y - i])
    end

    (1..8).each do |i|
      moves.push([x + i, y + i])
    end

    moves.select do |(x, y)|
      piece_on_board(x, y)
    end
  end

  def vertical_moves
    moves = []

    (1..8).each do |i|
      moves.push([x, y - i])
    end

    (1..8).each do |i|
      moves.push([x, y + i])
    end

    moves.select do |(x, y)|
      piece_on_board(x, y)
    end
  end

  def horizontal_moves
    moves = []

    (1..8).each do |i|
      moves.push([x - i, y])
    end

    (1..8).each do |i|
      moves.push([x + i, y])
    end

    moves.select do |(x, y)|
      piece_on_board(x, y)
    end
  end
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize
