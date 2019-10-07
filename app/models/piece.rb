class Piece < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def movement_direction(x_destination, y_destination)
    x_current = x_location
    y_current = y_location

    if x_current == x_destination # horizontal
      'horizontal'
    elsif y_current == y_destination # vertical
      'vertical'
    elsif (x_current - x_destination).abs == (y_current - y_destination).abs # diagonal
      'diagonal'
    else
      false
    end
  end

  def obstructed?(x_destination, y_destination)
    x_current = x_location
    y_current = y_location

    case movement_direction(x_destination, y_destination)
    when 'horizontal'
      y_low, y_high = [y_current, y_destination].sort
      (y_low + 1).upto(y_high - 1) { |y| return true if game.space_occupied?(x_current, y) }
    when 'vertical'
      x_low, x_high = [x_current, x_destination].sort
      (x_low + 1).upto(x_high - 1) { |x| return true if game.space_occupied?(x, y_current) }
    when 'diagonal'
      if x_current > x_destination && y_current > y_destination # down/left
        while x_current > x_destination && y_current > y_destination
          x_current -= 1
          y_current -= 1
          return true if game.space_occupied?(x_current, y_current)
        end
      elsif x_current > x_destination && y_current < y_destination # up/left
        while x_current > x_destination && y_current < y_destination
          x_current -= 1
          y_current += 1
          return true if game.space_occupied?(x_current, y_current)
        end
      elsif x_current < x_destination && y_current < y_destination # up/right
        while x_current < x_destination && y_current < y_destination
          x_current += 1
          y_current += 1
          return true if game.space_occupied?(x_current, y_current)
        end
      elsif x_current < x_destination && y_current > y_destination # down/right
        while x_current < x_destination && y_current > y_destination
          x_current += 1
          y_current -= 1
          return true if game.space_occupied?(x_current, y_current)
        end
      end
    else
      raise 'Invalid Move' # Invalid move. Change this to raise an error?
    end

    false
  end
end
