class GamesController < ApplicationController
  # before_action :authenticate_user!, only: [:new, :create]


  def new
    @game = Game.new
  end

  def index

  end
end
