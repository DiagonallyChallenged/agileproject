class GamesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create]


  def new
    @game = Game.new
  end

  def index
  end

  def create
    @game = Game.create(game_params)
    redirect_to root_path

  end

  private

  def game_params
    params.require(:game).permit(:name)
  end


end
