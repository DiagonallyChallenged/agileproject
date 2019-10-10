class Game < ApplicationRecord
  has_many :pieces
  belongs_to :black_player, class_name: 'User', optional: true
  belongs_to :white_player, class_name: 'User', optional: true
  belongs_to :winner, class_name: 'User', optional: true

  validates :name, presence: true

  scope :available, -> { where('black_player_id IS NULL OR white_player_id IS NULL') }

  def populate_game
    create_pawns
    create_major_pieces
  end

  def create_pawns
    (1..8).each do |pawn|
      Piece.create(x_location: pawn, y_location: 2, type: Pawn, game_id: id)
      Piece.create(x_location: pawn, y_location: 7, type: Pawn, game_id: id)
    end
  end

  def create_type(x_location, type)
    Piece.create(x_location: x_location, y_location: 1, type: type, game_id: id)
    Piece.create(x_location: x_location, y_location: 8, type: type, game_id: id)
  end

  def create_major_pieces
    create_type(1, Rook)
    create_type(8, Rook)
    create_type(2, Knight)
    create_type(7, Knight)
    create_type(3, Bishop)
    create_type(6, Bishop)
    create_type(4, Queen)
    create_type(5, King)
  end
end
