class Game < ApplicationRecord
  has_many :pieces
  belongs_to :black_player, class_name: 'User', optional: true
  belongs_to :white_player, class_name: 'User', optional: true
  belongs_to :winner, class_name: 'User', optional: true

  validates :name, presence: true

  scope :available, -> { where('black_player_id IS NULL OR white_player_id IS NULL') }

  def check_space(x, y)
    # May change depending on what happens to captured pieces.  May need to add active
    if self.pieces.where(["x_location = ? and y_location = ?", x, y]).count >= 1
      return true
    end
  end
end
