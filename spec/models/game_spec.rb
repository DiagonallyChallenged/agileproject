require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'available game scope' do
    let(:black_player) { FactoryBot.create(:user) }
    let(:white_player) { FactoryBot.create(:user) }

    let!(:white_player_null) { FactoryBot.create(:game, black_player_id: black_player.id) }
    let!(:black_player_null) { FactoryBot.create(:game, white_player_id: white_player.id) }
    let!(:neither_player_null) { FactoryBot.create(:game, black_player_id: black_player.id, white_player_id: white_player.id) }

    it 'should return games where black_player_id is null' do
      expect(Game.available).to include(black_player_null)
    end

    it 'should return games where white_player_id is null' do
      expect(Game.available).to include(white_player_null)
    end

    # it 'should not return games where neither id is null' do
    # expect(Game.available).not_to include(neither_player_null)
    # end #
  end

  describe '.create_pawns' do
    it 'should only create 16 pawns' do
      game = FactoryBot.create(:game)
      game.create_pawns
      expect(game.pieces.count).to eq(16)
    end

    it 'should create a piece type pawn' do
      game = FactoryBot.create(:game)
      game.create_pawns
      expect(game.pieces.last).to be_a Pawn
    end
  end

  describe '.create_type' do
    it 'should create two Rooks' do
      game = FactoryBot.create(:game)
      game.create_type(1, Rook)
      expect(game.pieces.count).to eq(2)
    end

    it 'should create a piece type Rook' do
      game = FactoryBot.create(:game)
      game.create_type(1, Rook)
      expect(game.pieces.last).to be_a Rook
    end

    it 'should be the correct location' do
      game = FactoryBot.create(:game)
      game.create_type(1, Rook)
      rook = game.pieces.last
      expect(rook.x_location).to eq(1)
      expect(rook.y_location).to eq(8)
    end
  end

  describe 'space_occupied? method' do
    it 'should return true if space has a piece' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)

      expect(game.space_occupied?(1, 1)).to be true
    end

    it 'should return false if space has no piece' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)

      expect(game.space_occupied?(3, 3)).to be false
    end
  end

  describe 'populate_game method' do
    it 'should populate a board when a game is joined' do
      game = FactoryBot.create(:game)
      game.populate_game
      expect(game.pieces.count).to eq(32)
    end
  end
end
