class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show, :update]

  def new
    @game = Game.new
  end

  def index
    @games = Game.available
  end

  def show
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?

    @pieces = @game.pieces
  end

  def create
    @game = Game.create(game_params)
    @game.join_game(current_user, 'white')
    if @game.valid?
      @game.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    game = Game.find(params[:id])
    game.join_game(current_user, 'black')
    game.save
    game.populate_game
    redirect_to game_path game
  end

  def destroy
    @game = Game.find(params[:id])
    return render_not_found if @game.blank?

    @game.destroy
    redirect_to root_path
  end

  private

  def game_params
    params.require(:game).permit(:name, :black_player, :white_player)
  end
end
