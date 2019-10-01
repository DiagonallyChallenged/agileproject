class GamesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @game = Game.new
  end

  def index; end

  def show
    @game = Game.find_by_id(params[:id])
    return render_not_found if @game.blank?
  end

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

  def render_not_found(status = :not_found)
    render plain: "#{status.to_s.titleize} :(", status: status
  end
end
