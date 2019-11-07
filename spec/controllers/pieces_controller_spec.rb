require 'rails_helper'

RSpec.describe PiecesController, type: :controller do
  describe 'pieces#show action' do
    it 'should display the piece show page' do
      game = Game.create(name: 'New Game')
      game.populate_game
      game.reload
      piece = game.pieces.last
      get :show, params: { id: piece.id }
      expect(response).to have_http_status(:ok)
    end

    it 'should return not_found if the piece does not exist' do
      get :show, params: { id: 'FAKE_ID' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'pieces#update action' do
    it 'should update the pieces location' do
      game = Game.create(name: 'New Game')
      game.populate_game
      game.reload
      piece = game.pieces.last
      new_x_location = piece.x_location + 1
      new_y_location = piece.y_location + 1
      patch :update, params: { id: piece.id, x_location: new_x_location, y_location: new_y_location }
      piece.reload
      expect(piece.x_location).to eq(new_x_location)
      expect(piece.y_location).to eq(new_y_location)
    end

    it 'should return true if move is valid' do
      game = Game.create(name: 'New Game')
      game.populate_game
      game.reload
      piece = game.pieces.last
      new_x_location = piece.x_location + 1
      new_y_location = piece.y_location + 1
      piece.move_to!(new_x_location, new_y_location)
      expect(piece.reload.x_location).to eq(new_x_location)
      expect(piece.reload.y_location).to eq(new_y_location)
    end
  end
end
