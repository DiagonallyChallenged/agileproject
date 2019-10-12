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
      patch :update, params: { id: piece.id, piece: { x_location: new_x_location, y_location: new_y_location } }
      piece.reload
      expect(piece.x_location).to eq(new_x_location)
      expect(piece.y_location).to eq(new_y_location)
    end

    it 'should return not_found if the piece does not exist' do
      patch :update, params: { id: 'FAKE_ID' }
      expect(response).to have_http_status(:not_found)
    end

    it 'should deactivate pieces on the destination square' do
      game = Game.create(name: 'New Game')
      game.populate_game
      game.reload
      moving_piece = game.pieces.last
      destination_piece = game.pieces.first
      patch :update, params: { id: moving_piece.id,
                               piece: { x_location: destination_piece.x_location,
                                        y_location: destination_piece.y_location } }
      moving_piece.reload
      destination_piece.reload
      expect(destination_piece.active).to be false
      expect(moving_piece.x_location).to eq(destination_piece.x_location)
      expect(moving_piece.y_location).to eq(destination_piece.y_location)
    end
  end
end
