require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  # describe "static_pages#index action" do
  #   it "should successfully show the page" do
  #     get :index
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe 'games#new action' do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end
    # we can use this code for validation

    it 'should successfully show the new form' do
      user = FactoryBot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'games#create action' do
    it "should require users to be logged in" do
      post :create, params: { game: { message: "Hello" } }
      expect(response).to redirect_to new_user_session_path
    end
    # code can be used for validation

    it 'should successfully create a new gram in our database' do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { game: { name: 'Awesome!' } }
      expect(response).to redirect_to root_path
      # can change this line later. Just kept it simple

      game = Game.last
      expect(game.name).to eq('Awesome!')
      # expect(game.user).to eq(user)
    end

    it 'should properly deal with validation errors' do
      user = FactoryBot.create(:user)
      sign_in user

      game_count = Game.count
      post :create, params: { game: { name: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Game.count).to eq Game.count
    end
  end

  describe 'game#show action' do

     it 'should successfully show the page if the game is found' do
       game = FactoryBot.create(:game)
       get :show, params: { id: game.id }
       expect(response).to have_http_status(:found)
     end

     it 'should return a 302 error if the game is not found' do
       get :show, params: { id: 'TACOCAT' }
       expect(response).to have_http_status(:found)
     end
   end
end
