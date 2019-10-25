class Rook < Piece
 def valid_move?(x_des:, y_des:)
    return false if obstructed?(x, y, x_des, y_des)
    if x == x_des 
      return true
    elsif y == y_des
      return true
    end
      
    
    false
  end
end
