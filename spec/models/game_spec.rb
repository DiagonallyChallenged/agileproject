require 'rails_helper'

RSpec.describe Game, type: :model do

  describe 'check_space method' do
    it 'should return true if space has a piece' do

      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)

      expect(game.check_space(1, 1)).to be true
    end
    
    it 'should return false if space has no piece' do

      game = FactoryBot.create(:game)
      user = FactoryBot.create(:user)
      piece = FactoryBot.create(:piece, id: 1, x_location: 1, y_location: 1, game_id: game.id, user_id: user.id)

      expect(game.check_space(3, 3)).to be false
    end

  end

end
