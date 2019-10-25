class Game < ApplicationRecord
  has_many :pieces
  belongs_to :black_player, class_name: 'User', optional: true
  belongs_to :white_player, class_name: 'User', optional: true
  belongs_to :winner, class_name: 'User', optional: true

  validates :name, presence: true

  scope :available, -> { where('black_player_id IS NULL OR white_player_id IS NULL') }

  attr_accessor :black_player_id, :white_player_id

  def join_game(user, color)
    if color == 'white'
      self.white_player = user
    elsif color == 'black'
      self.black_player = user
    end
  end

  def joined?(user)
    if [black_player, white_player].include?(user)
      true
    else
      false
    end
  end

  def populate_game
    create_pawns
    create_major_pieces
  end

  def create_pawns
    (1..8).each do |pawn|
      Piece.create(x_location: pawn, y_location: 2, type: Pawn, game: self, user: white_player)
      Piece.create(x_location: pawn, y_location: 7, type: Pawn, game: self, user: black_player)
    end
  end

  def create_type(x_location, type)
    Piece.create(x_location: x_location, y_location: 1, type: type, game: self, user: white_player)
    Piece.create(x_location: x_location, y_location: 8, type: type, game: self, user: black_player)
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

  def space_occupied?(x_location, y_location)
    get_piece_at_location(x_location, y_location).present? ? true : false
  end

  def get_piece_at_location(x_location, y_location)
    pieces.where(x_location: x_location, y_location: y_location, active: true).first
  end

  def check?(previous_move_player)
    opposing_king = pieces.where(type: 'King').where.not(user: previous_move_player).first
    kings_location = {
      x_des: opposing_king.x_location,
      y_des: opposing_king.y_location
    }

    previous_move_player.pieces.each do |piece|
      return true if piece.valid_move?(kings_location)
    end

    false
  end
end
