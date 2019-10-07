require 'rails_helper'

RSpec.describe Game, type: :model do
<<<<<<< HEAD
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

=======
>>>>>>> Made corrections from rubocop
  describe 'check_space method' do
    it 'should return true if space has a piece' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)

      expect(game.check_space(1, 1)).to be true
    end

    it 'should return false if space has no piece' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)

      expect(game.check_space(3, 3)).to be false
    end
  end
end
