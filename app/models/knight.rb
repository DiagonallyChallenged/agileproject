class Knight < Piece

  def valid_move?(x_des:, y_des:)
    valid_moves = [[(x_des + 2), (y_des + 1)], [(x_des + 2), (y_des - 1)], [(x_des + 2), (y_des + 1)]]
    move_to = [x_des, y_des]
    valid_moves.include?(move_to) ? true : false
  end
end
