class Game < ApplicationRecord

  has_many :pieces
  belongs_to :black_player, :class_name => 'User', :foreign_key => 'black_player_id'
  belongs_to :white_player, :class_name => 'User', :foreign_key => 'white_player_id'
  belongs_to :winner, :class_name => 'User', :foreign_key => 'winner_id'

  validates :name, presence: true
end
