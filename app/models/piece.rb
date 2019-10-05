class Piece < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def is_obstructed?(x_destination, y_destination)
    x_current = self.x_location
    y_current = self.y_location

    if x_current == x_destination # horizontal
      y_low, y_high = [y_current, y_destination].sort
      (y_low + 1).upto(y_high - 1) { |x| self.game.check_space(x_low, y) }
    elsif y_begin == y_high # vertical
      x_low, x_high = [x_current, x_destination].sort
      (x_low + 1).upto(x_high - 1) { |x| self.game.check_space(x, y_low) }
    elsif (x_current - x_destination).abs == (y_current - y_destination).abs #diagonal
      # figure diagonal

      

    else
      return 'Move not valid' # Invalid move. Change this to raise an error?
    end
  end
end
