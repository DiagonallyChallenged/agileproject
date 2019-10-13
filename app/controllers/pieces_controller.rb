class PiecesController < ApplicationController
  def show
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?

    @piece.update_attributes(pieces_params)
    redirect_to piece_path(@piece) #may eventually be removed
  end

  private

  def pieces_params
    params.require(:piece).permit(:x_location, :y_location)
  end
end
