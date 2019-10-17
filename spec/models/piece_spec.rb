require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe '.movement_direction' do
    subject(:instance) { Piece.new }

    it 'should return horizontal if movement is horizontal' do
      result = instance.movement_direction(1, 3, 3, 3)
      expect(result).to eq('horizontal')
    end

    it 'should return vertical if movement is vertical' do
      result = instance.movement_direction(1, 3, 1, 4)
      expect(result).to eq('vertical')
    end

    it 'should return diagonal if movement is diagonal' do
      result = instance.movement_direction(2, 4, 3, 5)
      expect(result).to eq('diagonal')
    end

    it 'return false if movement does not fall in any category' do
      result = instance.movement_direction(6, 3, 7, 1)
      expect(result).to be false
    end
  end

  describe 'capture_piece!' do
    it 'should deactive captured piece' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 2, game_id: game.id, user_id: user.id)
      piece.capture_piece!

      expect(piece.active).to be false
    end
  end

  describe 'update_piece_location!' do
    it 'should update piece location' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 2, game_id: game.id, user_id: user.id)
      piece.update_piece_location!(2, 4)

      expect(piece.x_location).to eq(2)
      expect(piece.y_location).to eq(4)
    end
  end

  describe '.horizontal_obstruction?' do
    it 'should return true if there is piece in the path' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 2, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 3, y_location: 2, game_id: game.id, user_id: user.id)

      result = piece.horizontal_obstruction?(1, 4, 2)
      expect(result).to be true
    end
  end

  describe '.vertical_obstruction?' do
    it 'should return true if there is piece in the path' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece = FactoryBot.create(:piece, id: 1, x_location: 3, y_location: 3, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 3, y_location: 3, game_id: game.id, user_id: user.id)

      result = piece.vertical_obstruction?(3, 4, 2)
      expect(result).to be true
    end
  end

  describe '.diagonal_obstruction?' do
    it 'should return true if there is piece in the path' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece = FactoryBot.create(:piece, id: 1, x_location: 3, y_location: 3, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 2, y_location: 2, game_id: game.id, user_id: user.id)

      result = piece.diagonal_obstruction?(piece.x_location, piece.y_location, 1, 1)
      expect(result).to be true
    end

    it 'should return false if there is no piece in the path' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece = FactoryBot.create(:piece, id: 1, x_location: 3, y_location: 3, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 4, y_location: 4, game_id: game.id, user_id: user.id)

      result = piece.diagonal_obstruction?(piece.x_location, piece.y_location, 1, 1)
      expect(result).to be false
    end
  end

  describe 'obstructed? method' do
    it 'should return false if path is clear' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece1 = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 3, y_location: 3, game_id: game.id, user_id: user.id)

      result = piece1.obstructed?(piece1.x_location, piece1.y_location, 1, 5)
      expect(result).to be false
    end

    it 'should return true for horizontal obstructions' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece1 = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 3, y_location: 1, game_id: game.id, user_id: user.id)

      result = piece1.obstructed?(piece1.x_location, piece1.y_location, 5, 1)
      expect(result).to be true
    end

    it 'should return true for vertical obstructions' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece1 = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 5, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 1, y_location: 3, game_id: game.id, user_id: user.id)

      expect(piece1.obstructed?(1, 5, 1, 1)).to be true
    end

    it 'should return true for diagonal obstructions' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece1 = FactoryBot.create(:piece, id: 1, x_location: 2, y_location: 4, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 3, y_location: 3, game_id: game.id, user_id: user.id)

      expect(piece1.obstructed?(2, 4, 5, 1)).to be true
    end
  end
end
