class PiecesController < ApplicationController
  def show
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?
  end

  def update
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?
    raise 'InvalidMove' unless @piece.correct_turn?

    @piece.move_to!(params[:x_location], params[:y_location])
    @piece.game.change_turn!

    respond_to do |format|
      format.html
      format.json
    end
  end

  private

  def pieces_params
    params.permit(:x_location, :y_location)
  end
end
