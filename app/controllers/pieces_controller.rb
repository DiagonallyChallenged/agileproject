class PiecesController < ApplicationController
  def show
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?

    @piece.move_to!(params[:x_location], params[:y_location])

    #@piece.update_attributes(pieces_params)
    redirect_to game_path(@piece.game)
  end

  private

  def pieces_params
    params.permit(:x_location, :y_location)
  end
end
