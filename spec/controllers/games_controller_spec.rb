require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  # describe "static_pages#index action" do
  #   it "should successfully show the page" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe 'games#new action' do
    it 'should successfully show the new form' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#create action' do
    it 'should successfully create a new gram in our database' do
      post :create, params: { game: { name: 'Awesome!' } }
      expect(response).to redirect_to root_path
      # can change this line later. Just kept it simple

      game = Game.last
      expect(game.name).to eq('Awesome!')
    end

    it 'should properly deal with validation errors' do
      post :create, params: { game: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Game.count).to eq 0
    end
  end
end
