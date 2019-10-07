require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe 'obstructed? method' do
    it 'should return false if path is clear' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece1 = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 3, y_location: 3, game_id: game.id, user_id: user.id)

      expect(piece1.obstructed?(3, 1)).to be false
    end

    it 'should return true for horizontal obstructions' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece1 = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 3, y_location: 1, game_id: game.id, user_id: user.id)

      expect(piece1.obstructed?(5, 1)).to be true
    end

    it 'should return true for vertical obstructions' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece1 = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 5, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 1, y_location: 3, game_id: game.id, user_id: user.id)

      expect(piece1.obstructed?(1, 1)).to be true
    end

    it 'should return true for diagonal obstructions' do
      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece1 = FactoryBot.create(:piece, id: 1, x_location: 2, y_location: 4, game_id: game.id, user_id: user.id)
      FactoryBot.create(:piece, id: 2, x_location: 3, y_location: 3, game_id: game.id, user_id: user.id)

      expect(piece1.obstructed?(5, 1)).to be true
    end
  end
end
