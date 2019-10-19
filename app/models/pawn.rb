class Pawn < Piece

  def valid_move?(x_des:, y_des:)
    x_distance = (x_des - x_location).abs
    y_distance = y_des - y_location

    color = self.piece_color
    return true if valid_vertical_move?(x_des, y_distance, color)

    false
  end

  def pawn_correct_direction?(distance, color)
    (color == 'white' && distance > 0) || (color == 'black' && distance < 1) ? true : false
  end

  def valid_double_move?(color)
    (color == 'white' && y_location == 2) || (color == 'black' && x_location == 7) ? true : false
  end

  def valid_vertical_move?(x_des, y_distance, color)
    if pawn_correct_direction?(y_distance, color)
      if y_distance.abs == 2
        if valid_double_move?(color)
          return true if game.space_occupied?(x_des, y_location)
        end
      elsif y_distance.abs == 1
        return true if game.space_occupied?(x_des, y_location)
      end
    end
  end
end
