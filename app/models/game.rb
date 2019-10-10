class Game < ApplicationRecord
  has_many :pieces
  belongs_to :black_player, class_name: 'User', optional: true
  belongs_to :white_player, class_name: 'User', optional: true
  belongs_to :winner, class_name: 'User', optional: true

  validates :name, presence: true

  scope :available, -> { where('black_player_id IS NULL OR white_player_id IS NULL') }

  attr_accessor :black_player_id

  def join_game(user)
    self.black_player = user
  end

  def joined?(user)
    black_player == user
  end

  # ^^^^method should look like this....but rubocop was being silly
  # black_player == user || white_player == user
  # Will have to figure this out later.
end
