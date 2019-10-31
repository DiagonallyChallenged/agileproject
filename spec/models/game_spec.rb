require 'rails_helper'

RSpec.describe Game, type: :model do
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

  describe '.joined?' do
    it 'should return true if current user is the white player' do
      game = FactoryBot.create(:game)

      join_status = game.joined?(game.white_player)
      expect(join_status).to be true
    end

    it 'should return true if current user is the black player' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      game.join_game(user, 'black')
      game.save

      join_status = game.joined?(game.black_player)
      expect(join_status).to be true
    end

    it 'should return false if a user is not in the game' do
      user = FactoryBot.create(:user)
      game = FactoryBot.create(:game)

      join_status = game.joined?(user)
      expect(join_status).to be false
    end
  end

  describe 'populate_game method' do
    it 'should populate a board when a game is joined' do
      game = FactoryBot.create(:game)
      game.populate_game
      expect(game.pieces.count).to eq(32)
    end
  end

  describe 'in_check?' do
    it 'should return true if oppenents king is in threat of capture' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      game.join_game(user, 'black')

      queen = FactoryBot.create(:piece, id: 1, x_location: 4, y_location: 4, type: 'Queen', game_id: game.id, user_id: game.white_player.id)
      FactoryBot.create(:piece, id: 2, x_location: 4, y_location: 8, type: 'King', game_id: game.id, user_id: user.id)

      check_status = game.in_check?(queen.user)
      expect(check_status).to be true
    end

    it 'should return false if oppenents king is not in threat' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      game.join_game(user, 'black')

      queen = FactoryBot.create(:piece, id: 1, x_location: 5, y_location: 6, type: 'Queen', game_id: game.id, user_id: game.white_player.id)
      FactoryBot.create(:piece, id: 3, x_location: 1, y_location: 3, type: 'Pawn', game_id: game.id, user_id: game.white_player.id)
      FactoryBot.create(:piece, id: 2, x_location: 4, y_location: 8, type: 'King', game_id: game.id, user_id: user.id)

      check_status = game.in_check?(queen.user)
      expect(check_status).to be false
    end
  end
end
