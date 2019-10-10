require 'rails_helper'

RSpec.describe PiecesController, type: :controller do

  describe 'pieces#show action' do
    it 'should display the piece show page' do
      post :create, params: { game: { name: 'New Game' } }
      piece = Game.last.pieces.last
      get :show, params: { id: piece.id }
      expect(response).to have_http_status(:found)
    end

    it 'should return not_found if the piece does not exist' do
      get :show, params: { id: 'FAKE_ID' }
      expect(response).to have_http_status(:render_not_found)
    end
  end

  describe 'pieces#update action' do
    it 'should update the pieces location' do
      post :create, params: { game: { name: 'New Game' } }
      piece = Game.last.pieces.last
      patch :update, params: { id: piece.id, piece: { x_location: 4 } }
      piece.reload
      expect(piece).to eq(4)
    end

    it 'should ureturn not_found if the piece does not exist' do
      patch :update, params: { id: 'FAKE_ID' }
      expect(response).to have_http_status(:render_not_found)
    end
  end
end
