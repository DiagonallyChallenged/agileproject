class PiecesController < ApplicationController
  def show
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?

    removed_piece = Piece.find_by(pieces_params, game_id: @piece.game.id)
    removed_piece&.deactivate!

    @piece.update_attributes(pieces_params)
  end

  private

  def pieces_params
    params.require(:piece).permit(:x_location, :y_location)
  end
end