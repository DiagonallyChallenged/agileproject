class Piece < ApplicationRecord
  belongs_to :user
  belongs_to :game
  alias_attribute :x, :x_location
  alias_attribute :y, :y_location
end
