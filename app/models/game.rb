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
		Piece.create({x_location: pawn, y_location: 2, type: Pawn, game_id: self.id})
		Piece.create({x_location: pawn, y_location: 7, type: Pawn, game_id: self.id})
  	end
  end

  def create_type(x_location, type)
  	Piece.create({x_location: x_location, y_location: 1, type: type, game_id: self.id})
  	Piece.create({x_location: x_location, y_location: 8, type: type, game_id: self.id})
  end


  def create_major_pieces
  	(1..8).each do |count|
  		case count
  		when 1, 8
  			create_type(count, Rook)
  		when 2, 7
  			create_type(count, Knight)
  		when 3, 6
  			create_type(count, Bishop)
  		when 4
  			create_type(count, Queen)
  		when 5
  			create_type(count, King)
  		end		
  	end
  end
end
