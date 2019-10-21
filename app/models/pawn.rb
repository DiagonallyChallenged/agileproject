class Pawn < Piece
  def valid_move?(x_des:, y_des:)
    x_distance = (x_des - x_location).abs
    y_distance = y_des - y_location
    color = piece_color

    if x_distance.zero?
      return true if valid_vertical_move?(x_des, y_distance, color) && pawn_correct_direction?(y_distance, color)
    elsif x_distance == 1
      return true if valid_diag_move?(x_des, y_des, x_distance, y_distance, color)
    end

    false
  end

  def pawn_correct_direction?(distance, color)
    (color == 'white' && distance.positive?) || (color == 'black' && distance.negative?) ? true : false
  end

  def valid_double_move?(x_destination, color)
    if (color == 'white' && y_location == 2) || (color == 'black' && x_location == 7)
      return true unless obstructed?(x_location, y_location, x_destination, y_location)
    end
    false
  end

  def valid_diag_move?(x_destination, y_destination, _x_distance, y_distance, color)
    if pawn_correct_direction?(y_distance, color) && y_distance == 1
      return true if occupied_by_opposing_piece?(x_destination, y_destination)
    end

    false
  end

  def occupied_by_opposing_piece?(x_destination, y_destination)
    if game.space_occupied?(x_destination, y_destination)
      return true if game.get_piece_at_location(x_destination, y_destination).user != user
    end
    false
  end

  def valid_vertical_move?(x_des, y_distance, color)
    return true if (y_distance.abs == 2 && valid_double_move?(x_des, color)) || y_distance.abs == 1

    false
  end
end
