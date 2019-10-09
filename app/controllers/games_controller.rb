class GamesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

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

  private

  def game_params
    params.require(:game).permit(:name)
  end

  def render_not_found(status = :not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end
end
