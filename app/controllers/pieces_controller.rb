class PiecesController < ApplicationController
  def show
    @piece = Piece.find_by_id(params[:id])
    return render_not_found if @piece.blank?
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength

  def update
    @piece = Piece.find_by_id(params[:id])
    raise 'InvalidMove' unless @piece.correct_turn?

    @piece.move_to!(params[:x_location], params[:y_location])

    return render_not_found if @piece.blank?

    x_des = params[:x_location]
    y_des = params[:y_location]

    @piece.move_to!(x_des, y_des) if @piece.valid_move?(x_des: x_des, y_des: y_des)

    respond_to do |format|
      format.html
      format.json
    end
    redirect_to game_path(@piece.game)
  end

  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  private

  def pieces_params
    params.permit(:x_location, :y_location)
  end
end
