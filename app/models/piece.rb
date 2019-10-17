class Piece < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :game
  alias_attribute :x, :x_location
  alias_attribute :y, :y_location

  def valid_move?(x:, y:)
    if obstructed?(self.x, self.y, x, y)
      return false
    end
  end

  def movement_direction(x_current, y_current, x_destination, y_destination)
    if y_current == y_destination # horizontal
      'horizontal'
    elsif x_current == x_destination # vertical
      'vertical'
    elsif (x_current - x_destination).abs == (y_current - y_destination).abs # diagonal
      'diagonal'
    else
      false
    end
  end

  def within_bounds?(x_current, y_current, x_destination, x_direction, y_direction)
    while x_current != x_destination
      x_current += x_direction
      y_current += y_direction
      return true if game.space_occupied?(x_current, y_current)
    end
    false
  end

  def diagonal_obstruction?(x_current, y_current, x_destination, y_destination)
    if x_current > x_destination && y_current > y_destination # down/left
      return true if within_bounds?(x_current, y_current, x_destination, -1, -1)
    elsif x_current > x_destination && y_current < y_destination # up/left
      return true if within_bounds?(x_current, y_current, x_destination, -1, 1)
    elsif x_current < x_destination && y_current < y_destination # up/right
      return true if within_bounds?(x_current, y_current, x_destination, 1, 1)
    elsif x_current < x_destination && y_current > y_destination # down/right
      return true if within_bounds?(x_current, y_current, x_destination, 1, -1)
    end
    false
  end

  def horizontal_obstruction?(x_current, x_destination, y_location)
    x_low, x_high = [x_current, x_destination].sort
    (x_low + 1).upto(x_high - 1) { |x| return true if game.space_occupied?(x, y_location) }
    false
  end

  def vertical_obstruction?(x_location, y_current, y_destination)
    y_low, y_high = [y_current, y_destination].sort
    (y_low + 1).upto(y_high - 1) { |y| return true if game.space_occupied?(x_location, y) }
    false
  end

  def obstructed?(x_current, y_current, x_destination, y_destination)
    case movement_direction(x_current, y_current, x_destination, y_destination)
    when 'horizontal'
      return true if horizontal_obstruction?(x_current, x_destination, y_current)
    when 'vertical'
      return true if vertical_obstruction?(x_current, y_current, y_destination)
    when 'diagonal'
      return true if diagonal_obstruction?(x_current, y_current, x_destination, y_destination)
    else
      raise 'Invalid Move'
    end
    false
  end
end
