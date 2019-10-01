class GamesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create]

  def new
    @game = Game.new
  end

  def index; end

  def create
    @game = Game.create(game_params)
    if @game.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:name)
  end
end
