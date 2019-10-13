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

    # @pieces = [
    #     {player_id: 2, pos_x: 3, pos_y: 3, type: "king", active: true},
    #     {player_id: 2, pos_x: 8, pos_y: 8, type: "queen", active: true},
    # ]

    return render_not_found if @game.blank?

    @pieces = @game.pieces
  end

  def create
    @game = Game.create(game_params)
    if @game.valid?
      @game.populate_game
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    game = Game.find(params[:id])
    game.join_game(current_user)
    game.save
    redirect_to game_path game
  end

  private

  def game_params
    params.require(:game).permit(:name, :black_player, :white_player)
  end
end
